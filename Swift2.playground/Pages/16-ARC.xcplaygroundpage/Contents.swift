//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Automatic Reference Counting

class Apartment {
    let number: Int
    init(number: Int) { self.number = number}
    var tenant: Person?
    deinit { print("Apartment #\(number) is being deinitialized")}
}

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleaseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

//:Strong Reference Cycles Between Class Instances
var john: Person?
var number73: Apartment?

john = Person(name: "John Appleaseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil

//:Resolving Strong Reference Cycles between class Instances
//:weak References and unowned References
/*:
weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime. Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.
*/
//:Weak References
//:Weak References must be declared as variables, to indicate that their value can change at runtime. A weak reference cannot be declared as a constant.

class Apartment_weak {
    let number: Int
    init(number: Int) { self.number = number}
    weak var tenant: Person?
    deinit { print("Apartment #\(number) is being deinitialized")}
}

//:Unowned References
//:Unlike a weak reference, an unowned reference is assumed to always have a value.
//:Because of this, an unowned reference is always defined as a non-optional type.

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    
    deinit { print("\(name) is being deinitialized")}
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit { print("Card #\(number) is being deinitialized")}
}

var john1: Customer?

john1 = Customer(name:"John Appleaseed")
john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)

john1 = nil

//:Unowned References and implicitly Unwrapped Optional Properties
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name:capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")

//:Strong Reference Cycles for Closures
/*:
A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure's body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to "capture" self, creating a strong reference cycle.
This strong refernce cycle occures because closures, like classes, are reference types. When you assign a closure to a property, you are assigning a reference to that closure.
Swift provides an elegant solution to this problem, known as a closure capture list.

Swift requires you to write self.someProperty or self.someMethod() whenever you refer to a member of self within a closure. This helps you remember that it's possible to capture self by accident.
*/

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil


//:Defining a Capture List
//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//    //closure body goes here
//}
//lazy var someClosure: Void -> String = {
//    [unowned self, weak delegate = self.delegate!] in
//    //closure body goes here
//}
























































