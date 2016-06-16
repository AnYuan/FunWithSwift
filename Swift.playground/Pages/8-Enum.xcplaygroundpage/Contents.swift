//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//: Enumeration Syntax
enum SomeEnumeration {
    //enumberation definition goes here
}

enum CompassPoint {
    case noreth, south, east, west
}

var directionToHead = CompassPoint.west
directionToHead = .east

//: Matching Enumeration Values with a Switch Statement

//: a switch statement must be exhaustive when considering an enumeration's members.
directionToHead = .south
switch directionToHead {
    case .noreth:
        print("north")
    case .south:
        print("south")
    case .east:
        print("east")
    case .west:
        print("west")
}


//: Associated Values
enum Barcode {
    case upca(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upca(8, 85909, 51225, 3)
switch productBarcode {
case .upca(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

switch productBarcode {
case let .upca(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}


//: Raw Values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/*: note that raw values are not the same as associated values.
Raw values are set to prepopulated values when yo first define the 
enumeration in your code, like the three ASCII codes above. The raw
value for a particular enumeration member is always the same. Associated
values are set when you create a new constant or variable based on one of the enumeration's members, and can be different each time you do so.
*/
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let earthsOrder = Planet.earth.rawValue
import UIKit
//: the raw value initializer always returns optional enumeration member
let possiblePlanet = Planet(rawValue: 7)






























