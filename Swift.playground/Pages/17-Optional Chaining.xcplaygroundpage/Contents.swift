//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

//:Optional Chaining
//:Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.

//:Optional Chaining as an Alternative to Forced Unwrapping
//:The main difference between Optional Chaining and forced unwrapping is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("\(roomCount)")
} else {
    print("noooooooooo")
}

//:Defining Model Classes for Optional Chaining
class Person_new {
    var residence: Residence_new?
}

class Residence_new {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("the number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {self.name = name}
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

let mike = Person_new()
if let roomCount = mike.residence?.numberOfRooms {
    print("has \(roomCount) rooms.")
} else {
    print("nooooooooooo");
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.buildingName = "Acacia Road"
mike.residence?.address = someAddress

/*:methods with no return type have an implicit return type of Void.
if you call this method on an optional value with optional chaining, the method's return type will be Void?, not Void.
*/

if mike.residence?.printNumberOfRooms() != nil {
    print("can print")
} else {
    print("can not print")
}

if (mike.residence?.address = someAddress) != nil {
    print("can set address")
} else {
    print("can not set address")
}

//:Accessing Subscripts Through Optional Chaining
if let firstRoomName = mike.residence?[0].name {
    print("first room name is \(firstRoomName)")
} else {
    print("noooooooôöòóœ")
}

mike.residence?[0] = Room(name:"Bathroom")

let mikesHouse = Residence_new()
mikesHouse.rooms.append(Room(name:"Living Room"))
mikesHouse.rooms.append(Room(name:"Kitchen"))
mike.residence = mikesHouse

if let firstRoomName = mike.residence?[0].name {
    print("\(firstRoomName)")
} else {
    print("nooooooooo")
}

//:Accessing Subscripts of Optional Type
var testScrores = ["Dave":[86,82,84], "Bev":[79,94,81]]
testScrores["Dave"]?[0] = 91
testScrores["Bev"]?[0]
testScrores["Brain"]?[0] = 82

//:Linking Multiple Levels of Chaining
if let mikesStreet = mike.residence?.address?.street {
    print("hahahah")
} else {
    print("nooooooo")
}







//:swich unwrap
var array = ["one", "two", "three"]

switch array.index(of: "four") {
case .some(let idx):
    array.remove(at: idx)
case .none:
    break
}

switch array.index(of: "four") {
case let idx?:
    array.remove(at: idx)
case nil:
    break
}

//: if let
if let idx = array.index(of: "four") {
    array.remove(at: idx)
}

if let idx = array.index(of: "four") , idx != array.startIndex {
    array.remove(at: idx)
}

let urlString = "http://www.google.com/images/srpr/logo11w.png"
if let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
    let view = UIImageView(image: image)
//    Playground.currentPage.liveView = view
}

if let url = URL(string: urlString) , url.pathExtension == "png",
    let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        let view = UIImageView(image: image)
}


//:while let
let array_int = [1,2,3]
var generator = array_int.makeIterator()
while let i = generator.next() {
    print(i)
}

var a: [()->Int] = []

for i in 1...3 {
    a.append { i }
}

for f in a {
    print("\(f()) ")
}

var g = (1...3).makeIterator()
var o: Optional<Int> = g.next()
while o != nil {
    let i = o!
    a.append { i }
    o = g.next()
}

//:Doubly nested optionals
let stringNumbers = ["1", "2", "3", "foo"]
let maybeInts = stringNumbers.map{ Int($0)}
for maybeInt in maybeInts {
    print(maybeInt)
}

var generator_ = maybeInts.makeIterator()
while let maybeInt = generator_.next() {
    // maybeInt is an `Int?`
    // three numbers and a `nil`
}

for case let i? in maybeInts {
    // i will be an Int, not an Int?
    // 1, 2 and 3
}
// or only the nil values:
for case nil in maybeInts {
    // will run once for each nil
}

//:This uses a "pattern" of x?, which only matches non-nil values. This is shorthand for .Some(x), so the loop could be written like this:
for case let .some(i) in maybeInts {
}

/*:
this case-based pattern matching is a way to apply the same rules that work in switch statements to if, for and while. it's most useful with optionals, but also has other applications
*/
let i = 5
if case 0..<10 = i {
    print("\(i) within range")
}

/*:
Since case matching is extensible via implementations of the ~= operator, this means you can extend if case and for case in various interesting ways:
*/
struct Substring {
    let s: String
    init(_ s: String) { self.s = s }
}

func ~=(pattern: Substring, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}

let s = "bar"
if case Substring("foo") = s {
    print("has substring \"foo\")")
}

//:if var and while var
if var i = Int(s) {
    i += 1
    print(i)
}

//:Scoping of unwrapped optionals

//ugly code below
//func doStuffWithFileExtension(fileName: String) {
//    let period: String.Index
//    if let idx = fileName.characters.indexOf(".") {
//        period = idx
//    } else {
//        return
//    }
//    
//    let extensionRange = period.successor()..<fileName.endIndex
//    let fileExtension = fileName[extensionRange]
//    print(fileExtension)
//}


//func doStuffWithFileExtension(_ fileName: String) {
//    guard let period = fileName.characters.index(of: ".")
//        else { return } //must leave the current scope. return or fatalError
//    
//    let extensionRange = String.CharacterView.index(after: period)..<fileName.endIndex
//    let fileExtension = fileName[extensionRange]
//    print(fileExtension)
//}



//:Optional chaining for function and subscript
let dictOfArrays = ["nine":[0,1,2,3,4,5,6,7]]
let sevenOfNine = dictOfArrays["nine"]?[7]

let dictOfFuncs: [String: (Int, Int) -> Int] = [
    "add":(+),
    "subtract":(-)
]

dictOfFuncs["add"]?(1,1)


/*:you can assign through an optional chain. Suppose you have an optional variable, and if its non-nil, you wish to update one of its properties:
if splitViewController != nil {
    splitViewController!.delegate = myDelegate
}

Instead, you can assign to be the chained optional value, and if it isn't nil, the assignment will work:
splitViewController?.delegate = myDelegate
*/


/*:
Nil-coalescing operator
if let n = i ?? j {
    //similar to if i != nil || j != nil
}

if let n = i, m = j {
    //similar to if i != nil && j != nil
}
*/
let s1: String?? = nil
(s1 ?? "inner") ?? "outer"
let s2: String?? = .some(nil)
(s2 ?? "inner") ?? "outer"
s1
s2












