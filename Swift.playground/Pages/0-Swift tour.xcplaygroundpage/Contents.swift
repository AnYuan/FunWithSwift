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
func greet(_ name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
greet("Anyuan", day: "Tuesday")

func sumOf(_ numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42,23,23)



func makeIncrementer() -> ((Int) -> Int) {
    func addOne(_ number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


func hasAnyMatches(_ list:[Int], condition:(Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(_ number: Int) -> Bool {
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
let sortedNumbers = numbers.sorted{$0 > $1}
print(sortedNumbers)

//objects and class

//enum and structures
enum Rank : Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDes() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 11) {
    let threeDes = convertedRank.simpleDes()
}

//Mon, 19 Oct 2015 03:05:37 GMT
let dateFormat = DateFormatter()
let gmt = TimeZone(abbreviation: "GMT")
dateFormat.timeZone = gmt
//dateFormat.dateStyle = .MediumStyle
//dateFormat.timeStyle = .LongStyle

dateFormat.dateFormat = "E, dd MMM yyyy H:mm:SS z"

dateFormat.string(from: Date())


protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}


Int.arbitrary()

func tabulate<A>(_ times: Int, transform: (Int) -> A) -> [A] {
    return (0 ..< times).map(transform)
}

extension Int {
    static func random(_ from: Int, to: Int) -> Int{
        return from + (Int(arc4random()) % (to - from))
    }
}

extension Character: Arbitrary {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(Int.random(65,to:90)))
    }
}

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = Int.random(0, to: 40)
        let randomChracters = tabulate(randomLength) {
            _ in Character.arbitrary()
        }
        return String(randomChracters)
    }
}

String.arbitrary()




(0 ..< 10).map{print($0)}

struct Point {
    var x: Int
    var y: Int
}

var structPoint = Point(x: 1, y: 2)
var sameStructPoint = structPoint
sameStructPoint.x = 3


var mutablePoint = Point(x: 1, y: 1)
mutablePoint.x = 3
print(mutablePoint)

var arr = [1,2,5]
arr.removeAll()
let res = arr.first.flatMap {
    arr.reduce($0, combine: max)
}
res

enum Result<T> {
    case success(T)
    case failure(ErrorProtocol)
}


let seq = stride(from:0, to: 9, by: 1)
var g1 = seq.makeIterator()
g1.next()
g1.next()

var g2 = g1
g1.next()
g1.next()
g2.next()
g2.next()

var g3 = AnyIterator(g1)

g3.next()
g1.next()
g3.next()
g3.next()
g1.next()


class PropertyQuiz {
    var property: String = "1" {
        willSet {
            self.property = "2"
        }
        didSet {
            self.property = "3"
        }
    }
    
    init() { }
}

class PropertySubQuiz: PropertyQuiz {
    
    override var property: String {
        get {
            return super.property
        }
//        set { } // case 1
        set { super.property = "6" } // case 2
    }
    
    override init() {
        super.init()
        self.property = "4"
        config()
    }
    
    func config() {
        self.property = "5"
    }
}

let subQuiz = PropertySubQuiz()
print(subQuiz.property)






var a3 = Array(1..<10)
var a4 = a3[1..<3]
a3[1] = 10
a4



var filename = "hi.5.4.dmg.abc"

var array = filename.components(separatedBy: ".")

//filename
if array.count <= 2 {
    array.removeFirst()
} else if array.count > 2{
    array.removeLast()
    let result = array.joined(separator: ".")
}

var filename1 = "dmg.abc.pdf"
var array1 = filename1.components(separatedBy: ".")


//file ext
if array1.count > 1 {
    array1.removeLast()
} else {
    ""
}






