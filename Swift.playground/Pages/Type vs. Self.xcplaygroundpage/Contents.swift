import Foundation

import UIKit

let object: Any = "beep loop"
let isString = object is String

let mirror = Mirror(reflecting: object)
let typeofObject: Any.Type = mirror.subjectType

let isStringType = typeofObject is String.Type

let str = "a"
String.self


struct S {}
protocol P {}

enum E {}


print("\(type(of: S.self))")      // S.Type
print("\(type(of: E.self))")      // S.Type
print("\(type(of: S.Type.self))") // S.Type.Type
print("\(type(of: P.self))")      // P.Protocol
print("\(type(of: P.Type.self))") // P.Type.Protocol


let metatype: String.Type = String.self
let other = metatype.init("c")
print(other)



