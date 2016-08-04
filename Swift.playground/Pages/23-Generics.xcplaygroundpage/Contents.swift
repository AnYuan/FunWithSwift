//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Generics

//:Generic Functions
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
someInt
anotherInt

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
someString
anotherString


//:Generic Types
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()

//:Extending a Generic Type
extension Stack {
    var topItem: T?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("\(topItem)")
}

//:Type Constraints
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    
//}

/*:
the hypothetical function above has two type parameters. The first type parameter, T, has a type constraint that requires T to be a subclass of SomeClass. The sencond type parameter, U, has a type constraint that requires U to conform to be protocol SomeProtocol.
*/

func findStringIndex(_ array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print(foundIndex)
}


func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//:Associated Types
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack_: Container {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    typealias ItemType = Int
    mutating func append(item: ItemType) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

/*:
this time, the placeholder type parameter T is used as the type of the append(_:) method's item parameter and the return type of the subscript. Swift can therefore infer that T is the appropriate type to use as the ItemType for this particular container.
*/
struct Stack_<T>: Container {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> T{
        return items[i]
    }
}

extension Array: Container {}

//:Where Clauses
func allItemsMatch< C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable> (someContainer: C1, _ anotherContainer: C2) -> Bool {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

















