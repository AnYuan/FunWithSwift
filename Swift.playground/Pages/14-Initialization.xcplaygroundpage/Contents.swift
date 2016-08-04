//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

/*: Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

    You implement this initialization process by defining initializers, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.
    Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.
*/

//:Setting Initial Values for Stored Properties
//:Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is create. Stored properties cannot be left in an indeterminate state.
//:Note
//:When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}


var f = Fahrenheit()
f.temperature

//:default property values
struct Fahrenheit_default {
    var temperature = 32.0
}


//:Initialization Parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius
let bodyTemperature = Celsius(37.0)


struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}


let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//:Optinal Property Types
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."


//:Assigning Constant Properties During Initialization
class SurveyQuestion_const {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets."

//:default initializers
class ShoppingListItem_ {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem_()

//:Initializer Delegation for Value Types
//:Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer(or the memberwise initializer, if it is a structure) for that type.
//:if you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extionsion rather tan as part of the value type's original implementation.
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
//    init() {}
//    init(origin: Point, size: Size) {
//        self.origin = origin
//        self.size = size
//    }
//    
//    init(center: Point, size: Size) {
//        let originX = center.x - (size.width / 2)
//        let originY = center.y - (size.height / 2)
//        self.init(origin: Point(x: originX, y: originY), size: size)
//    }
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
basicRect

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))


struct Test_cus {
    var origin = Point()
    var size = Point()
}


/*:Initializer Delegation for Class Types
Rule 1:
A designated initializer must call a designated initializer from its immediate superclass.
Rule 2:
A convenience initializer must call another initializer from the same class.
Rule 3:
A convenience initializer must ultimately call a designated initializer.

A simple way to remember this is:
* Designated initializers must always delegate up.
* Convenience initializers must always delegate across.

Two-Phase Initialization
In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined
The second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considerd ready for use.
*/

//:Initializer Inheritance and overriding
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
bicycle.description

//:Automatic Initializer Inheritance
/*:
Rule 1:
If your subclass doesn't define any designated initializers, it automatically inherits all of its superclass designated initializers.
Rule 2:
If your subclass provides an implementation of all of its superclass designated initializers -- either by inheriting them as per rule1, or by providing a custom implementation as part of its definition --then it automatically inherits all of the superclass convenience initializers.
*/

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
oneMysteryItem.name
oneMysteryItem.quantity
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) * \(name)"
        output += purchased ? "yes" : "no"
        return output
    }
}

var breakfastList = [ShoppingListItem(), ShoppingListItem(name: "Bacon"), ShoppingListItem(name: "eggs", quantity: 6)]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

//:Failable Initializers for struct

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {return nil}
        self.species = species
    }
}


let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//:Failable Initializers for Enumerations
//enum TemperatureUnit {
//    case Kelvin, Celsius, Fahrenheit
//    
//    init?(symbol: Character) {
//        switch symbol {
//            case "K":
//                self = .Kelvin
//            case "C":
//                self = .Celsius
//            case "F":
//                self = .Fahrenheit
//            default:
//                return nil
//        }
//    }
//}

//:Failable Initializers for Enumerations with Raw Values
enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("nil")
}

//:Failable Initializers for classes
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty {return nil}
    }
}

//:Propagation of Initialization Failure
class CartItem: Product {
    let quantity: Int!
    init?(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 {return nil}
    }
}


if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("has something")
} else {
    print("nil")
}

//:Overriding a Failable Initializer
class Document {
    var name: String?
    init() {}
    init?(name: String) {
        self.name = name
        if name.isEmpty {return nil}
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[untitled]"
    }
    
    override init?(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[untitled]"
        } else {
            self.name = name
        }
    }
}

//:The init! Failable Initializer
//can delegate from init? to init! and vice versa
//can override init? with init! and vice versa


//:Required Initializers
class SomeClass {
    required init() {
        
    }
}

//you do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
class SomeSubclass: SomeClass {
    required init() {
        
    }
}


//:Setting a default property value with a Closure or Function
//class SomeClass {
//    let someProperty: SomeType = {
//       return someValue
//    }()
//}

//:Note that the closure's end curly brace is followed by an empty pair of parentheses. This tells Swift to extecute the closure immediately. if you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
//:If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance's methods.

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(_ row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
board.squareIsBlackAtRow(0, column: 1)
board.squareIsBlackAtRow(9, column: 9)
























































