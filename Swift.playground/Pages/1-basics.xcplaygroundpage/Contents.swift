////: [Previous](@previous)
//
import Foundation
//
//var str = "Hello, playground"
//
//var intN: UInt8 = 3
//
//let minValue = UInt8.min
//let maxValue = UInt8.max
//
//typealias AudioSample = UInt16
//var maxAmplitudeFound = AudioSample.min
//
////Tuples
//let http404Error = (404, "Not Found")
//let (statusCode, statusMessage) = http404Error
//print(http404Error.0)
//print(http404Error.1)
//
//let http200Status = (statusCode: 200, statusMessage:"OK")
//print(http200Status.statusMessage)
//
//var serverResponseCode: Int? = 404
//serverResponseCode = nil
//let possibleNumber = "123"
//let convertedNumber = Int(possibleNumber)
//if convertedNumber != nil {
//    print("convertedNumber contains some integer value. \(convertedNumber!)")
//}
//
//if let actualNumber = Int(possibleNumber) {
//    print("has")
//} else {
//    print("no value")
//}
//
//
//let possibleString: String? = "An optional string."
//let forcedString: String = possibleString!
//
//let assumedString: String! = "An implicitly unwrapped optinalal string."
//let implicitString: String = assumedString
//
//if assumedString != nil {
//    print(assumedString)
//}
//
//if let definiteString = assumedString {
//    print(definiteString)
//}
//
////Error Handling
//func canThrowAnError() throws {
//    //this function may or may not throw an error
//}
//
//do {
//    try canThrowAnError()
//    //no error was thrown
//} catch {
//    //an error was thrown
//}
//
//
//
//var dict :[String:String?] = [:]
//// first try
//dict = ["key": "value"]
//dict["key"] = Optional<Optional<String>>.none
//dict
//
//// second try
//dict = ["key": "value"]
//dict["key"] = Optional<String>.none
//dict
//
//// third try
//dict = ["key": "value"]
//dict["key"] = nil
//dict
//
//// forth try
//dict = ["key": "value"]
//let nilValue:String? = nil
//dict["key"] = nilValue
//dict
//
//// fifth try
//dict = ["key": "value"]
//let nilValue2:String?? = nil
//dict["key"] = nilValue2
//dict
//
//let a: Int? = nil
//let b: Int?? = a
//let c: Int??? = b
//let d: Int??? = nil
//
//let e: Int?? = nil
//
//if let _ = e {
//    print("e is not none")
//}
//
//if let _ = b {
//    print("b is not none")
//}
//
//if let _ = c {
//    print("c is not none")
//}
//
//
//
//
//let r = [1,2,3].lazy.flatMap { n in n..<5 }
//print(r)
//let first = r.first(where: { $0 % 2 == 0 })
//print(first)
//
//let rr = (1...10).lazy.flatMap { n in n % 2 == 0 ? n/2 : nil }
//
//func increment(x: Int) -> Int {
//    print("computing next value of \(x)")
//    return x+1
//}
//
//let array = Array(0..<1000)
////let incArray = array.map(increment)
//
//let lazy_incArray = array.lazy.map(increment)
//print(lazy_incArray[0], lazy_incArray[4])
//
//func foo(x: inout String) {
//    
//}
//
//enum Coin {
//    case heads, tails
//    func printMe() {
//        switch self {
//        case .heads: print("heads")
//        case .tails: print("tails")
//        }
//    }
//}
//
//
func f() -> Int! { return 3 }
let x1 = f()
let x2: Int? = f()
let x3: Int! = f()
let x4: Int = f()
//if let x4 = x4 {
//    print("true")
//}
let a1 = [f()]
//let a2 : [Int!] = [f()]
let a3: [Int] = [f()]

func g() -> Int! { return nil }
let y1 = g()
let y3: Int! = g()
//let y4: Int = g()
let b1 = [g()]
//let b2: [Int!] = [g()]
//let b3: [Int] = [g()]

func p<T>(x: T) { print(x) }
p(x: f())

if let x5 = f() {
    print("here")
}

if let y5 = g() {
    print("not run")
}


class Person: NSObject {
    @objc dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var friends: [Person] = []
    @objc dynamic var bestFriend: Person?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}


let firstNameGetter = #selector(getter: Person.firstName)
let firstNameSetter = #selector(setter: Person.firstName)


let chris = Person(firstName: "Chris", lastName: "Lattner")
let joe = Person(firstName: "Joe", lastName: "Groff")
let douglas = Person(firstName: "Douglas", lastName: "Gregor")
chris.friends = [joe, douglas]
chris.bestFriend = joe

#keyPath(Person.firstName)
chris.value(forKey: #keyPath(Person.firstName))
#keyPath(Person.bestFriend.lastName)
chris.value(forKeyPath: #keyPath(Person.bestFriend.firstName))
chris.value(forKeyPath: #keyPath(Person.friends.firstName))

//let swiftArray = ["Chris", "Joe", "Douglas"]
//let nsArray: NSArray = NSArray(array: swiftArray)
////swiftArray.value(forKey: #keyPath(swiftArray.uppercased))
////swiftArray.map {}
////swiftArray.value(forKeyPath: #keyPath(swiftArray.count))
//nsArray.count
////swiftArray.value(forKeyPath: #keyPath(nsArray.count))
//nsArray.value(forKeyPath: #keyPath(nsArray.length))




let dictionary = ["one": 1, "two": 2]
let values = dictionary.values
//let jsonData = try JSONSerialization.data(withJSONObject: values, options: [])
print(values)
for v in values {
    print(v)
}


enum ListNode<A> {
    case end
    indirect case cons(A, ListNode)
}

extension ListNode: Collection {
    var startIndex: Int { return 0 }
    /// This is 0(n), not the expected O(1) from `Collection`.
    var endIndex: Int {
        switch self {
        case .end: return 0
        case .cons(_, let tail): return 1 + tail.endIndex
        }
    }
    func index(after: Int) -> Int {
        return after+1
    }
    /// This is 0(n), not the expected O(1) from `Collection`.
    subscript(position: Int) -> A {
        switch (self, position) {
        case (.end, _): fatalError("Index out of bounds")
        case (.cons(let x, _), 0): return x
        case (.cons(_, let tail), _): return tail[position-1]
        }
    }
}



let trueNumber = NSNumber(value: true)
let falseNumber = NSNumber(value: false)
let trueObjCType = String(cString: trueNumber.objCType)
let falseObjCType = String(cString: falseNumber.objCType)

let number:AnyObject = NSNumber(value: true)
print(number)
let objcType = String(cString: number.objCType)

let boolString = String("true")


let a = NSNumber(value: 0)
let b = NSNumber(value: false)

a == b





