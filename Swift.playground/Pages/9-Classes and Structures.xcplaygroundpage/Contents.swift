
import Foundation

var str = "Hello, playground"

/*: 
### Classes VS Structures
#### Both can:
* Define properties to store values
* Define methods to provide functionality
* Define subscripts to provide access to their values using subscript syntax
* Define initializers to set up their initial state
* Be extended to expand their functionality beyond a default implementation
* Comform to protocols to provide standard functionality of a certain kind

#### Classes have additional capabilities that Structures DO NOT:
* Inheritance enables one class to inherit the characteristics of another.
* Type casting enables you to check and interpret the type of a class instance at runtime.
* Deinitializers enable an instance of a class to free up any resources it has assigned.
* Reference counting allows more than one reference to a class instance.
*/


//: Definition Syntax
class SomeClass {
    
}

struct SomeStructure {
    
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//:Class and Structure Instance
let someResolution = Resolution()
let someVideoMode = VideoMode()

//:Accessing Properties
print(someResolution.height)
print(someVideoMode.resolution.width)
someVideoMode.resolution.width = 1280

//:Memberwise Initializers for Structure Type
let vga = Resolution(width: 640, height: 480)

//:Structures and Enumerations are Value Types
//Struct
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
hd.width
//enum
enum CompassPoint {
    case north, south, east, west
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east
if rememberedDirection == .west {
    print("west")
}

//:Classes are Reference Types
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

tenEighty.frameRate


/*:
#### Identity Operators:
* Identical to (===)
* Not identical to (!==)
* "Identical to" means that two constants or variables of class type refer to exactly the same class instance.
* "Equal to" means that two instances are considered "equal" or "equivalent" in value, for some appropriate meaning of "equal", as defined by the type's designer.
*/
if tenEighty === alsoTenEighty {
    print("refer to the same VideoMode instance")
}


/*:
#### Choosing Structures
* The structure's primary purpose is to encapsulate a few relatively simple data values.
* It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
* Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
* The structure does not need to inherit properties or behavior from another existing type.
*/




































