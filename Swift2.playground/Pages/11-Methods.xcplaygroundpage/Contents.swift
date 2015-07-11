//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


//: Method
//:Instance Methods
class Counter {
    var count = 0
    func increment() {
        ++count
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func incrementBy(amount: Int, numberOfTimes:Int) {
        count += amount * numberOfTimes
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.incrementBy(10)
counter.incrementBy(5, numberOfTimes: 3)
counter.reset()

//:Modifying value Types from within instance method
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
somePoint.x
somePoint.y

//:Note that you cannot call a mutating method on a constant of structure type, because its properties cannot be changed, even if they are variable properties.
let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0) error here

//:Assigning to self within a mutating method
//:mutating methods can assign an entirely new instance to the implicit self property. The Point example shown above could have been written in the following way insead:
struct Point_self {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point_self(x: x + deltaX, y: y + deltaY)
    }
}


enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()

//: Type Method
//: Note: In Swift, you can define type-level methods for all classes, structures, and enumerations.
class SomeClass {
    class func someTypeMethod() {
        print("some type method")
    }
}

SomeClass.someTypeMethod()

//:within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type.

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level:Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    
    mutating func advanceToLevel(level:Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
LevelTracker.highestUnlockedLevel

player = Player(name:"Beto")
if player.tracker.advanceToLevel(6) {
    print("level 6")
} else {
    print("level 6 has not yet been unlocked")
}




















