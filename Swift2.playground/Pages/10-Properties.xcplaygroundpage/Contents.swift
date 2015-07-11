//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

/*:
#### Properties:
* Computed Properties, Stored Properties, Type Properties.

##### Computed properties
* class, structure, enumeration

##### Stored Properties
* class, structure
*/

//: Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    var length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//:this will report an error, even though firstValue is a variable property
//:this behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.
//:the same is not true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance's variable properties.
//rangeOfFourItems.firstValue = 6
rangeOfFourItems.firstValue


//:Lazy Stored Properties
//:You must always declare a lazy property as a variable(with the var keyword)

class DataImporter {
    var filename = "data.text"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("Some more data")
//:if a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property has not yet been initialized, there is no guarantee that the property will be initialized only once.

//:Computed properties
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)


//:Read-Only conputed properties
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

//:Property Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("about to set new \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("did set \(totalSteps)")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200


//:Type Properties
/*:Type Properties are useful for defining values that are universal to all instances of a particular type, such as constant property that all instances can use, or a variable property that stores a value that is global to all instances of that type.

   For value types(struct and enum), you can define stored and computed type properties.
   For classes, you can define computed type properties only.
   Stored type properties for value types can be variables or constants. You must always give stored type properties a default value. This is because the type iteself does not have an initializer that can assign a value to a stored type property at initialization time.
   Computed type properties are always declared as variable properties.
*/
struct SomeStructure {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty:Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty:Int {
        return 107
    }
}

SomeStructure.storedTypeProperty = "another value"





































