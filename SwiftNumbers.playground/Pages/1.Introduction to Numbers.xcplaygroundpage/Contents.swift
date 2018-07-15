import UIKit

//FixedWidthInteger
UInt8.bitWidth
Int.bitWidth

UInt8.max
UInt8.min

Int8.min
Int8.max

//handling overflows
var i: Int8 = 127
//error
//i + 1

let u = UInt8.max
u &+ 1

let c = UInt8.max

c.addingReportingOverflow(1)

//BinaryInteger
let b = 747
let int16 = Int16(b)

//let int8 = Int8(b)
let p = 57
UInt(exactly: p)

let n = -33
UInt(exactly: n)

Int8(exactly: 123.0)
Int8(exactly: 1234.0)
Int8(exactly: 123.123)


Int8(clamping: 0xA320)
UInt8(clamping: -757)

let uu: UInt8 = 0b11110000//240
Int8(truncatingIfNeeded: u) //-16
UInt8(truncatingIfNeeded: u) //240


0.1 + 0.2 == 0.3

-0.0 == 0.0
0.0.isZero
Double.infinity.isFinite

(-Double.infinity).floatingPointClass == .negativeInfinity

//NaN (not a number)
Double.nan == Double.nan
Double.nan.isNaN

//BinaryFloatingPoint
Float.exponentBitCount
Float.significandBitCount

Double.exponentBitCount
Double.significandBitCount

Float80.exponentBitCount
Float80.significandBitCount

//Comparing Floating-point Numbers
let lhs = 0.1
let rhs = 0.2
let sum = lhs + rhs

Float.ulpOfOne
Float.greatestFiniteMagnitude
Float.leastNormalMagnitude.ulp


//infix operator ==~ : ComparisonPredicate
//func ==~<T> (lhs: T, rhs: T) -> Bool where T:FloatingPoint {
//    return  lhs == rhs || lhs.nextDown == rhs || lhs.nextUp == rhs
//}

extension FloatingPoint {
    func isApproximatelyEqual(to other: Self,
                              within margin: Self?,
                              maximumULPs ulps: Int = 1) -> Bool {
        precondition(margin?.sign != .minus && ulps > 0)
        
        guard self != other else {
            return true
        }
        let difference = abs(self - other)
        if let margin = margin, difference > margin {
            return false
        } else {
            return difference <= (self.ulp * Self(ulps))
        }
    }
}

let bitPattern: UInt32 = 0b00111101100111001010110000001000
let string = String(bitPattern, radix: 2, uppercase: false)
let paddedString = String(repeating: "0", count: 32 - string.count) + string
paddedString == "00111101100111001010110000001000"
Float(bitPattern: bitPattern) == Float(0.0765)
