//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//Array
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


//Dic
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


























































