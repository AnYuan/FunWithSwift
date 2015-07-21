//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Protocols
/*:
A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.
*/

//:Syntax
//protocol SomeProtocol {
//    
//}

//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    
//}

//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    
//}

//:Property Requirements
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//an example of a protocol with a single instance property requirement
protocol FullyNamed {
    var fullName: String { get }
}


struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "enterprise", prefix: "USS")







