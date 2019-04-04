import Foundation


var funcations: [() -> Int] = []
for i in 1...3 {
    funcations.append { i }
}
for f in funcations {
    print("\(f())")
}


// Doubly Nested Optionals

let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map { Int($0) }

//var iterator = maybeInts.makeIterator()
//while let maybeInt = iterator.next() {
//    print(maybeInt)
//}


for case let i? in maybeInts {
    print(i)
}

for case nil in maybeInts {
    print("no value")
}

for case let .some(i) in maybeInts {
    print(i)
}


let j = 5
if case 0..<10 = j {
    print("\(j) within range")
}


struct Pattern {
    let s: String
    init(_ s: String) { self.s = s }
}

func ~= (pattern: Pattern, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}


let s = "Taylor Swift"
if case Pattern("Swift") = s {
    print("\(String(reflecting: s)) contains \"Swift\"")
}

let numbers = ["1", "2", "3", "foo"]
print(numbers.compactMap{Int($0)}.reduce(0, +))


let ns = [[1], [2,3], [4]]
print(ns.flatMap { $0 })

