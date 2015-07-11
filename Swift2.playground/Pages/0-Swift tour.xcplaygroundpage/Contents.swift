////: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)

var float : Float = 3
print(float)

let label = "This width is "
let width = 94
let widthLabel = label + String(width)

let widthLabelxx = label + "\(width)"

var shoppingList = ["catfish","water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
shoppingList

var occupations = ["Malcolm":"Captain",
                   "Kaylee":"Mechanic"]
occupations["Jayne"] = "public relations"
occupations["Jayne"] = "public change"
occupations

let emptyArray = [String]()
let emptyDic = [String:Float]()

shoppingList = []
occupations = [:]

let individualScores = [75,43,103,87,12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore)


var optainalString: String? = "Hello"
print(optainalString == nil)

var optionalName: String? = nil

var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, nobody"
}

let vegetable = "red pepper"
switch vegetable {
    case "celery":
    let vegetableComment = "add some raisins and make ants on a log."
    case "cucumber", "watercress":
    let vegetableComment = "that would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "is it a spicy \(x)?"
default:
    let vegetableComment = "everything tastes good in soup."
}


var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

//functions and closures
func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
greet("Anyuan", day: "Tuesday")

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42,23,23)



func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


func hasAnyMatches(list:[Int], condition:Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 20
}
var numbers = [20,19,7,12]
//hasAnyMatches(numbers, condition: lessThanTen)
//let maps = numbers.map({
//    $0 * 3
//    
//})

let maps = [1,2,3].map({
    $0 * 3
    
})

print(maps)
let sortedNumbers = numbers.sort{$0 > $1}
print(sortedNumbers)

//objects and class

//enum and structures
enum Rank : Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDes() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.Ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 11) {
    let threeDes = convertedRank.simpleDes()
}






































