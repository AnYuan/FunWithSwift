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
