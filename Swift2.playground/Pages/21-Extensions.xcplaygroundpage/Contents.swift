//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Extensions
/*:
Extensions add new functionality to an existing class, structure, enumeration, or protocol type.

Extensions in Swift can:
* add computed properties and computed type properties
* define instance methods and type methods
* provide new initializers
* define subscripts
* define and use new nested types
* make an existing type conform to a protocol
*/

/*: Note
Extensions can add new functionality to a type, but they cannot override existing functionality.
*/

//: Syntax
//extension SomeType {
//    
//}

//extension SomeType: SomeProtocol, AnotherProtocol {
//    
//}

//:Computed Properties
extension Double {
    var km: Double {return self * 1_000.0}
    var m: Double {return self}
    var cm: Double {return self / 100.0}
    var mm: Double {return self / 1_000.0}
    var ft: Double {return self / 3.28084}
}

let oneInch = 25.4.mm
let threeFeet = 3.ft

//:Note
//:Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.

//:Initializers
/*:
Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.

Note:
If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and does not define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension's initializer.
*/

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:Point(x: originX, y: originY), size: size)
    }
}


//:Methods
extension Int {
    func repetitions(_ task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}


3.repetitions({
    print("hello!")
})

3.repetitions {
    print("bye bye")
}


//:Mutating Instance Methods
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

//:Subscripts
extension Int {
    subscript(digitIndex: Int) -> Int {
        var digitIndex = digitIndex
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            digitIndex -= 1
        }
        return (self / decimalBase) % 10
    }
}

74234123123123[0]
74234123123123[1]

//:Nested types
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", appendNewline: false)
        case .zero:
            print("0 ", appendNewLine: false)
        case .positive:
            print("+ ", appendNewLine: false)
        }
    }
    print("")
}

printIntegerKinds([3,-27,0])










































