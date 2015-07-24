//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Protocols
/*:
A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.
*/

//:Syntax
//protocol SomeProtocol {
//    
//}

//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    
//}

//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    
//}

//:Property Requirements
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//an example of a protocol with a single instance property requirement
protocol FullyNamed {
    var fullName: String { get }
}


struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "enterprise", prefix: "USS")

//:Method Requirements
/*:
Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are writeen as part of the protocol's definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, cannot be specified for method parameters within a protocol's defination.
As with type property requirements, you always prefix type method requirements with the static keyword when they are defined in a protocol. This is true even though type methdod requirements are prefixed with the class or static keyword when implemented by class:
*/
//protocol SomeProtocol {
//    static func SomeTypeMethod()
//}
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
generator.random()
generator.random()


//:Mutating Method Requirements
/*:
if you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.
*/

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}


var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()


//:Initializer Requirements
/*:
you can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier
you do not need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes cannot be subclassed.
*/

//protocol SomeProtocol {
//    init(someParameter: Int)
//}

//class SomeClass: SomeProtocol {
//    required init (someParameter: Int) {
//        
//    }
//}

//protocol SomeProtocol {
//    init()
//}
//
//class SomeSuperClass {
//    init() {
//        
//    }
//}
//
//class SomeSubClass: SomeSuperClass, SomeProtocol {
//    required override init() {
//        
//    }
//}


//:Failable Initializer Requirements
/*:
Protocols can define failable initializer requirements for conforming types
A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
*/


//:Protocols as Types
/*:
Protocols do not actually implement any functionality themselves. Nonetheless, any protocol you create will become a fully-fledged type for use in your code.
Because it is a type, you can use a protocol in many places where other types are allowed, including:
* As a parameter type or return type in a function, method, or initializer
* As the type of a constant, variable, or property
* As the type of items in an array, dictionary, or other container
*/

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print(d6.roll())
}


//:Delegation
protocol DiceGame {
    var dice: Dice {get}
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRolldiceRoll: Int)
    func gameDidEnd(game: DiceGame)
}


//:Adding Protocol Conformance with an Extension
/*:
You can extend an existing type to adopt and conform to a new protocol, even if you do not have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.
*/

protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

//:Declaring Protocol Adoption with an Extension
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}


extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
somethingTextRepresentable.asText()
/*:
Types do not automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.
*/


//:Collections of Protocol Types
let things: [TextRepresentable] = [simonTheHamster, d6]

for thing in things {
    thing.asText()
}

//:Protocol Inheritance
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    //protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

//:Class-Only Protocols
/*:
You can limit protocol adoption to class types (and not structures or enumerations) by adding the class keyword to a protocol's inheritance list. The class keyword must always appear first in a protocol's inheritance list, before any inherited protocols
*/
//protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
//    
//}

/*:
use a class-only protocol when the behavior defined by that protocol's requirements assumes or requires that a conforming type has reference semantics rather than value semantics.
*/

//:Protocol Composition
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person_: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("\(celebrator.name), \(celebrator.age)")
}

let birthdayPerson = Person_(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


//:Checking for Protocol Conformance
/*:
* The is operator returns ture if an instance conforms to a protocol and returns false if it does not.
* The as? version of the downcast operator returns an optional vlaue of the protocol's type, and this value is nil if the instance does not conform to that protocol.
* The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.
*/

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.14
    var radius: Double
    var area: Double { return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objectes: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 234_234),
    Animal(legs: 4)
]

for object in objectes {
    if let objectWithArea = object as? HasArea {
        print("area is \(objectWithArea.area)")
    } else {
        print("something do not have an area")
    }
}


//:Optional Protocol Requirements
/*:
Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
This attribute indicates that the protocol should be exposed to Objective-C code. Even if you are not interoperating with Objective-C, you need to mark your protocols with the @objc attribute if you want to specify optaional requirements.
Note also that @objc protocols can be adopted only by classes, and not by structures or enumerations. If you mark your protocol as @objc in order to specify optional requrements, you will only be able to apply that protocol to class types.
*/
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
                count += amount
        }
    }
}

class ThreeSource: CounterDataSource {
    let fixedIncrement = 3
}


//:Protocol Extensions
/*:
Protocols can be extended to provide method and property implementations to conforming types.
This allows you to define behavior on protocols themselves, rather than in each type's individual conformance or in a global function.
*/
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

/*:
By creating an extension on the protocol, all conforming types automatically gain this method implementation without any additional modification.
*/
generator.randomBool()


//:Providing Default Implementations
/*:
You can use protocol extensions to provide a default implementation to any method or property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
Note: protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don't have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
*/
extension PrettyTextRepresentable {
    func asPrettyText() -> String {
        return asText()
    }
}

//:Adding Constraints to Protocol Extensions
extension CollectionType where Generator.Element: TextRepresentable {
    func asList() -> String {
        return "(" + ", ".join(map({$0.asText()})) + ")"
    }
}

let murraytheHamster = Hamster(name:"Murray")
let morganTheHamster = Hamster(name:"Morgan")
let mauriceTheHamster = Hamster(name:"Maurice")

let hamsters = [murraytheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.asList())









