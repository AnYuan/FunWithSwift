//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//: Enumeration Syntax
enum SomeEnumeration {
    //enumberation definition goes here
}

enum CompassPoint {
    case Noreth, South, East, West
}

var directionToHead = CompassPoint.West
directionToHead = .East

//: Matching Enumeration Values with a Switch Statement

//: a switch statement must be exhaustive when considering an enumeration's members.
directionToHead = .South
switch directionToHead {
    case .Noreth:
        print("north")
    case .South:
        print("south")
    case .East:
        print("east")
    case .West:
        print("west")
}


//: Associated Values
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51225, 3)
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let productCode):
    print("QR code: \(productCode)")
}

switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .QRCode(productCode):
    print("QR code: \(productCode)")
}


//: Raw Values
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/*: note that raw values are not the same as associated values.
Raw values are set to prepopulated values when yo first define the 
enumeration in your code, like the three ASCII codes above. The raw
value for a particular enumeration member is always the same. Associated
values are set when you create a new constant or variable based on one of the enumeration's members, and can be different each time you do so.
*/
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthsOrder = Planet.Earth.rawValue
import UIKit
//: the raw value initializer always returns optional enumeration member
let possiblePlanet = Planet(rawValue: 7)






























