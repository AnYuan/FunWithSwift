//: [Previous](@previous)

import Foundation

struct Address {
    var street: String
}

struct Person {
    var name: String
    var addresses: [Address]
}

typealias Addressbook = [Person]



final class Ref<A> {
    typealias Observer = (A) -> ()
    
    private let _get: () -> A
    private let _set: (A) -> ()
    private let _addObserver: (@escaping Observer) -> Disposable
    
    var value: A {
        get {
            return _get()
        }
        set {
            _set(newValue)
        }
    }
    
    init(get: @escaping () -> A, set: @escaping (A) -> (), addObserver: @escaping (@escaping Observer) -> Disposable) {
        _get = get
        _set = set
        _addObserver = addObserver
    }
    
    func addObserver(observer: @escaping Observer) -> Disposable {
        return _addObserver(observer)
    }
}

extension Ref {
    convenience init(initialValue: A) {
        var observers: [Int: Observer] = [:]
        var theValue = initialValue {
            didSet {observers.values.forEach{$0(initialValue)}
        }
        var freshId = (Int.min...).makeIterator()
        let get = { theValue }
        let set = { newValue in theValue = newValue}
        let addObserver = { (newObserver: @escaping Observer) -> Disposable in
            let id = freshId.next()!
            observers[id] = newObserver
            return Disposable {
                observers[id] = nil
            }
        }
        self.init(get: get, set: set, addObserver: addObserver)
    }
}





