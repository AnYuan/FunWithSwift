//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//: 1. Functions can be assigned to variables and passed in and out of other functions as arguments.
func printInt(_ i: Int) {
    print("you passed \(i)")
}

let funVar = printInt

funVar(2)

func useFunction(funParam: (Int) -> ()) {
    funParam(3)
}

useFunction(funParam: printInt)

useFunction(funParam: funVar)

func returnFunc() -> (Int) -> String {
    func innerFunc(_ i: Int) -> String {
        return "you passed \(i) to the returned function"
    }
    return innerFunc
}

let myFunc = returnFunc()
myFunc

//: 2. Functions can "capture" variables that exist outside of their local scope.

//: 3. Functions can be declared using the {} syntax for closure expressions.


//: Functions as Delegates
protocol Observable {
    associatedtype Event
    mutating func register<O: Observer where O.Event == Event>(observer: O)
}

protocol Observer {
    associatedtype Event
    func receive(_ event: Event)
}

struct StringEventReceiver: Observer {
    func receive(_ event: String) {
        print("Received:\(event)")
    }
}


struct StringEventGenerator: Observable {
    var observers: [(String)-> ()] = []
    typealias Event = String
    mutating func register<O : Observer where O.Event == String>(observer: O) {
        observers.append{observer.receive($0)}
    }
    
    func fireEvents(_ event: String) {
        for observer in observers {
            observer(event)
        }
    }
}



