//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Advanced Operators

//:Bitwise Operators

//:Bitwise NOT Operator
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

//:Bitwise AND Operator
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits

//:Bitwise OR Operator
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits

//:Bitwise XOR Operator
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits

//:Bitwise Left and Right Shift Operators
/*:
The bit-shifting behavior for unsigned integers is as follows:
1. Existing bits are moved to the left or right by the requested number of places.
2. Any bits that are moved beyond the bounds of the integer's storage are discarded.
3. Zeroes are inserted in the spaces left behind after the original bits are moved to the left or right.
*/
let shiftBits: UInt8 = 4
shiftBits << 1
shiftBits << 2
shiftBits << 5
shiftBits << 6 // rule 2
shiftBits >> 2

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16
let greeenComponent = (pink & 0x00FF00) >> 8
let blueComponent = pink & 0x0000FF

//:Shifting Behavior for Signed Integers
/*:
when you shift signed integers to the right, apply the same rules as for unsigned integers, but fill any empty bits on the left with the sign bit, rather than with a zero.
*/


//:Overflow Operators
/*:
* overflow addition (&+)
* overflow subtraction (&-)
* overflow multiplication (&*)
*/

var unsignedOverflow = UInt8.max
var unsignedOverflow_ = UInt8.max

unsignedOverflow = unsignedOverflow &+ 1
unsignedOverflow_ = unsignedOverflow_ &- 1

//:Precedence and Associativity
2 + 3 * 4 % 5

//:Operator Functions
/*:
classes and structures can provide their own implementations of existing operators. This is known as overloading the existing operators.
*/

struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector


//:Prefix and Postfix Operators
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative

//:Compound Assignment Operators
func += ( left: inout Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

prefix func ++ ( vector: inout Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement


//:Equivalence Operators
func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("equal")
}

//:Custom Operators
//:new operators are declared at a global level using the operator keyword, and are marked with the prefix, infix or postfix modifiers
prefix operator +++ {}
prefix func +++ ( vector: inout Vector2D) -> Vector2D {
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

//:Precedence and Associativity for Custom Infix Operators
infix operator +- {associativity left precedence 140}
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVecotr = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVecotr


