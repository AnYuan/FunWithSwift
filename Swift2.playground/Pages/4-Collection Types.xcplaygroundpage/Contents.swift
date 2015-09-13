//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//:Array
var someInts = [Int]()
print(someInts.count)

someInts.append(3)

var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)

var sixDoubles = threeDoubles + anotherThreeDoubles

var shoppingList:[String] = ["Egg", "Milk"]

if shoppingList.isEmpty {
    print("is empty")
} else {
    print("not empty")
}

shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
var firstItem = shoppingList.first
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", atIndex: 0)
let mapleSyrup = shoppingList.removeAtIndex(0)
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerate() {
    print("Item \(index + 1): \(value)")
}

//:Transforming Arrays

//:map

let fibs = [0, 1, 1, 2, 3, 5]

var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}

squared

let squared_ = fibs.map{$0 * $0}
squared


extension Array {
    func map<U>(transform: Element->U) -> [U] {
        var result: [U] = []
        result.reserveCapacity(self.count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

extension Array {
    func flatMap<U>(transform: Element->[U]) -> [U] {
        var result: [U] = []
        for x in self {
            result.appendContentsOf(transform(x))
        }
        return result
    }
}

let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J","Q","K","A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

allCombinations


fibs.indexOf(2)

//:filter
let a = fibs.filter{$0 % 2 == 0}
a

extension Array {
    func filter(includeElement: Element -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

//:reduce
var total = 0
for num in fibs {
    total = total + num
}

fibs.reduce(0){ total, num in total + num}
fibs.reduce(0, combine: +)
let fibs_str = fibs.reduce(""){str, num in str + "\(num)\n"}
fibs_str

extension Array {
    func reduce<U>(initial: U, combine: (U,Element)->U) -> U {
        var result = initial
        for x in self {
            result = combine(result,x)
        }
        return result
    }
}


//:Dic
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB":"Dublin"]

airports.count

airports["LHR"] = "London"
airports["LHR"] = "London Hearthrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("\(oldValue)")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}


airports["APL"] = "Apple International"
airports["APL"] = nil
airports

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


//Useful extension for Dictionary
//merge two dics
extension Dictionary {
    mutating func merge<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
            for (k,v) in other {
                self[k] = v
            }
    }
}

//init with (key,value)
extension Dictionary {
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
            self = [:]
            self.merge(sequence)
    }
}

//map value
extension Dictionary {
    func mapValues<NewValue>(transform: Value -> NewValue)
        -> [Key:NewValue] {
            return Dictionary<Key, NewValue>(map { (key,value) in
                return (key, transform(value))
                })
    }
}


//Set
var letters = Set<Character>()
print(letters.count)
letters.insert("a")
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hiphop"]
favoriteGenres.insert("Jazz")

favoriteGenres.remove("Rock")

favoriteGenres.contains("Jazz")
favoriteGenres.sort()
favoriteGenres


//Performing Set Operations
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]

oddDigits.union(evenDigits).sort()

oddDigits.intersect(evenDigits).sort()
oddDigits.subtract(singleDigitPrimeNumbers).sort()
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

































































