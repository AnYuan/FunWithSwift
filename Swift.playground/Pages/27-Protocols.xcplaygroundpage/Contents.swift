//: [Previous](@previous)

import Foundation
import UIKit

//Advacend Swift Protocol Chapter Source Code

var str = "Hello, playground"

//: [Next](@next)

struct DateRange {
    var startDate: NSDate
    var endDate: NSDate
    
    func contains(date: NSDate) -> Bool {
        return false
    }
}

extension DateRange {
    init(startDate: NSDate = NSDate(), durationInDays days: Int = 1) {
        self.startDate = startDate
        self.endDate = self.startDate
    }
}

protocol CalendarViewDelegate {
    
}

struct Event {
    let title: String
    let date: NSDate
    let durationInSeconds: TimeInterval
}

extension Event: HasDate {}


protocol HasDate {
    var date: NSDate {get}
}

class MyCalendarView: UIView {
    
    var displayRange: DateRange = DateRange()
    var delegate: CalendarViewDelegate?
    var events:[Event] = []
    
    func setupViews() {
        let displayedEvents = events.filter {
            displayRange.contains(date: $0.date)
        }
        
        for event in displayedEvents {
            addEventView(event: event)
        }
    }
    
    func addEventView(event: Event) {
        
    }
}


extension MyCalendarView: CalendarView {}

protocol CalendarView {
    
    associatedtype EventType
    
    var displayRange: DateRange {get set}
    var delegate: CalendarViewDelegate? {get set}
    var events:[EventType] {get set}
}

extension CalendarView where EventType: HasDate {
    var eventsInRange: [EventType] {
        return events.filter {displayRange.contains(date: $0.date)}
    }
}


struct TextCalendarView: CalendarView {
    var displayRange: DateRange = DateRange()
    var delegate: CalendarViewDelegate?
    var events:[Event] = []
    
    func display() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        for event in eventsInRange {
            print("\(formatter.string(from: event.date as Date)):\(event.title)")
        }
        
    }
}

protocol Shareable {
    var socialMediaDescription: String {get}
    func share()
}

extension Shareable {
    func share() {
        print("Sharing: \(self.socialMediaDescription)")
    }
    
    func linesAndShare() {
        print("---------")
        share()
        print("---------")
    }
}

extension String: Shareable {
    var socialMediaDescription: String {return self}
    
    func share() {
        print("Special String Sharing:\(self.socialMediaDescription)")
    }
}


"hello".share()
"hello".linesAndShare()

let hello: Shareable = "hello"
hello.share()



// Protocols with Self Requirements
protocol EventLike {
    var date: NSDate {get}
    var title: String {get}
    func overlapsWith(other: Self) -> Bool
}

extension Event: EventLike {
    
    func overlapsWith(other: Event) -> Bool {
        return date.timeIntervalSince(other.date as Date) < durationInSeconds ||
        other.date.timeIntervalSince(date as Date) < other.durationInSeconds
    }
}

struct EventStorage<E:EventLike> {
    let events: [E]
}

extension EventStorage {
    func containsOverlappingEvent(event: E) -> Bool {
        return !events.lazy.filter(event.overlapsWith).isEmpty
    }
}

//Associated Types
protocol StoringType {
    associatedtype Stored
    
    init(_ value: Stored)
    func getStored() -> Stored
}

struct IntStorer: StoringType {
    private let stored: Int
    init(_ value: Int) {
        stored = value
    }
    
    func getStored() -> Int {
        return stored
    }
}

struct StringStorer: StoringType {
    private let stored: String
    init(_ value: String) {
        stored = value
    }
    
    func getStored() -> String {
        return stored
    }
}


let intStorer = IntStorer(5)
intStorer.getStored()

let stringStorer = StringStorer("five")
stringStorer.getStored()


// Protocol Internals

extension SignedNumber {
    var myAbs: Self {
        if self < 0 {
            return -self
        } else {
            return self
        }
    }
}

let i: Int8 = -4
let k = i.myAbs
k

func takesProtocol(x: CustomStringConvertible) {
    // this will print 40 every time
    print(sizeofValue(x))
}

takesProtocol(x: 4)
takesProtocol(x: "string")


func takesPlaceholder<T: CustomStringConvertible>(x: T) {
    //this will print whatever the size of
    //the argument type is (for example, Int64
    //is 8, Int8 is 1, class references are 8)
    print(sizeofValue(x))
}


takesPlaceholder(x: 1 as Int64)
class MyClass: CustomStringConvertible {
    var description: String {
        return "\(MyClass.self)"
    }
}

takesPlaceholder(x: MyClass())


extension CustomStringConvertible {
    func asExtension() {
        print(sizeofValue(self))
    }
}

(1 as Int16).asExtension()
MyClass().asExtension()


func dumpCustomStringConvertible(c: CustomStringConvertible) {
    var p = c
    //you cloud also do this with unsafeBitCast
    withUnsafePointer(&p) { (ptr) -> Void in
        let intPtr = UnsafePointer<Int>(ptr)
        for i in stride(from: 0, to: sizeof(CustomStringConvertible.self)/8, by: 1) {
            print("\(i):\t 0x\(String(intPtr[i], radix: 16))")
        }
    }
}


let ii = Int(0xb1ab1ab1a)
dumpCustomStringConvertible(c: i)


//Performance Implications
protocol NumberGeneratorType {
    mutating func generateNumber() -> Int
}

struct RandomGenerator: NumberGeneratorType {
    func generateNumber() -> Int {
        return Int(arc4random_uniform(10))
    }
}

struct IncrementingGenerator: NumberGeneratorType {
    var n: Int
    init(start: Int) { n = start }
    mutating func generateNumber() -> Int {
        n += 1
        return n
    }
}

struct ConstantGenerator: NumberGeneratorType {
    let n: Int
    init(constant: Int) {
        n = constant
    }
    
    func generateNumber() -> Int {
        return n
    }
}


func generateUsingProtocol(g: NumberGeneratorType, count: Int) -> Int {
    let start = NSDate()
    var generator = g
    return stride(from: 0, to: count, by: 1).reduce(0) {
        total, _ in
        let end = NSDate().timeIntervalSince(start as Date)
        print(end)
        return total &+ generator.generateNumber()

    }
}

func generateUsingGeneric<T: NumberGeneratorType>(g: T, count: Int) -> Int {
    var generator = g
    return stride(from: 0, to: count, by: 1).reduce(0) {
        total, _ in
        return total &+ generator.generateNumber()
    }
}


//generateUsingProtocol(RandomGenerator(), count: 10000)
//generateUsingGeneric(RandomGenerator(), count: 10000)
//generateUsingGeneric(ConstantGenerator(constant:0), count: 10000)

sizeof(String.self)
sizeof(Any.self)


class C {}
class D: C {}

let d = D()
let c: C = d

unsafeBitCast(d, to: UnsafePointer<Void>.self)
unsafeBitCast(c, to: UnsafePointer<Void>.self)

func f(cs: [C]) {}
let ds = [D(), D()]
f(cs: ds)

protocol P {}
extension C: P {}

sizeofValue(C())
sizeofValue(C() as P)


func g(ps:[P]) {}
//will not compile, needs transformation 
//g(ds)































