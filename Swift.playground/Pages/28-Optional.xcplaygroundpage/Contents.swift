//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


// Doubly Nested Optionals
let stringNumbers = ["1","2","3","foo"]
let maybeInts = stringNumbers.map{Int($0)}

for maybeInt in maybeInts {
    //Int? here
    print(maybeInt)
}

var generator = maybeInts.makeIterator()
while let maybeInt = generator.next() {
    //Int? here
    print(maybeInt)
}

for case let i? in maybeInts {
    //Int here
    print(i)
}

extension Int {
    func half() -> Int? {
        guard self > 1 else {
            return nil
        }
        return self / 2
    }
    
    func double() -> Int {
        return self * 2
    }
}


let half = 20.half()?.half()?.half()
let num = Int("20")?.double().double().double()

extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}

let array = [1,2,3]
//array[5]
let nilvalue = array[safe: 5]

let op_int = Int("123")
op_int.map { _ in print("have value") }

array.reduce(0, combine: +)

extension Array {
    func reduce(_ combine: (Element, Element) -> Element) -> Element? {
        return first.map {
            self.dropFirst().reduce($0, combine: combine)
        }
    }
}
array.reduce(+)

//extension Optional {
//    func map<U>(transform: (Wrapped) -> U) -> U? {
//        if let value = self {
//            return transform(value)
//        }
//        return nil
//    }
//}

let x = stringNumbers.first.map {Int($0)}//Int??

stringNumbers.flatMap {Int($0)}
             .reduce(0, combine: +)


var dicWithNils: [String: Int?] = ["one":1, "two":2, "none":nil]
dicWithNils["two"] = nil//remove key "two"
dicWithNils

dicWithNils["two"] = Optional(nil)
dicWithNils

dicWithNils["two"] = nil//remove key "two"
dicWithNils

dicWithNils["two"] = .some(nil)
dicWithNils

dicWithNils["two"] = nil//remove key "two"
dicWithNils

dicWithNils["two"]? = nil
dicWithNils


dicWithNils["three"]? = nil
dicWithNils.index(forKey: "three")

dicWithNils


let a:[Int?] = [1,2,nil]
let b:[Int?] = [1,2,nil]

func ==<Element: Equatable>(lhs:[Element], rhs:[Element]) -> Bool {
    return true
}

func ==<T: Equatable>(lhs:[T?], rhs:[T?]) -> Bool {
    return lhs.elementsEqual(rhs) { $0 == $1 }
}

//not supported for now
//extension Optional: Equatable where T: Equatable{
//    
//}

a == b


//:switch-case Matching for Optionals
func ~=<T:Equatable>(pattern:T?, value:T?) -> Bool {
    return pattern == value
}

//func ~=<I:ClosedInterval>(pattern:I, value:I.Bound?) -> Bool {
//    return value.map{ pattern.contains($0)} ?? false
//}

//:Improving Force-Unwrap Error Messages
infix operator !! {}

func !!<T>(wrapped:T?, failureText:@autoclosure ()->String) -> T {
    if let x = wrapped {return x}
    fatalError(failureText())
}

let s = "1"

//let i = Int(s) !! "Expecting integer, got \"\(s)\""

infix operator !? {}
func !?<T:IntegerLiteralConvertible>(wrapped:T?, failureText:@autoclosure ()->String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? 0
}

let j = Int(s) !? "Expecting integer, got \"\(s)\""

func !?<T:ArrayLiteralConvertible>(wrapped:T?, failureText:@autoclosure ()->String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? []
}

func !?<T:StringLiteralConvertible>(wrapped:T?, failureText:@autoclosure ()->String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? ""
}

func !?<T>(wrapped:T?, nilDefault: @autoclosure ()-> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

func !?(wrapped:()?, failureText: @autoclosure ()-> String) {
    assert(wrapped != nil, failureText)
}

var ss: String! = "Hello"
ss?.isEmpty
if let ss = ss { print(ss) }
ss = nil
ss ?? "GoodBye"











