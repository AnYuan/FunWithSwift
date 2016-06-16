//: [Previous](@previous)

import Foundation

//Nil Coalescing Operator
//shorthand for the code a ?? b
//a != nil ? a! : b

let defaultColorName = "red"
var userDefinedColorName: String? //defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
