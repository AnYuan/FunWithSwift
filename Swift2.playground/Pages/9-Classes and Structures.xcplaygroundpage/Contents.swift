
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

