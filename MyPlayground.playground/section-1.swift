import Foundation

var str :String? = "Hello Swift by Tutorials"

if let unwrappedStr = str
{
    println("Unwrapped! \(unwrappedStr.uppercaseString)")
}
else
{
    println("Was nil")
}

var maybeString : String? = "Hello Swift by Tutorials!"
let uppercase = maybeString?.uppercaseString

println(uppercase!)

var array: [Int] = [1,2,3,4,5]
array.append(6)
array.extend(7...10)
array


var anyObjectArray : [AnyObject] = [1,2,3, "3"]

var dictionary = [1: "Dog", 2: "Cat"]
dictionary[3] = "Mouse"
println(dictionary)
dictionary[2] = "Elephant"
println(dictionary)
dictionary[3] = nil
println(dictionary)
if let value = dictionary[1]
{
    println("Value is \(value)")
}

var dicationaryA = [1:1, 2:4, 3:9, 4:16]
var dicationaryB = dicationaryA
println(dicationaryA)
println(dicationaryB)

dicationaryB[4] = nil
println(dicationaryA)
println(dicationaryB)

var arrayA = [1,2,3,4,5]
var arrayB = arrayA
println(arrayA)
println(arrayB)

arrayB.removeAtIndex(0)
println(arrayA)
println(arrayB)

import Foundation

func square(number: Double) -> Double
{
    return number * number
}

let operation = square

let a = 3.0, b = 4.0
let c = sqrt(operation(a) + operation(b))

println(c)

func logDouble(number:Double)
{
    println(String(format: "%.2f",number))
}

var logger : (Double) -> Void = logDouble
logDouble(c)

func checkAreEqual<T:Equatable>(value:T,expected:T, message:String)
{
    if expected != value
    {
        println(message)
    }
}

"abc" == "abc"

checkAreEqual(47, 48.67, "test")

var aa = 2.0
func m_square(inout number:Double)
{
    number = number * number
    println(number)
}

m_square(&aa)
println(aa)

class Person {
    var age = 34, name = "Colin"
    
    func growOlder()
    {
        self.age++
    }
}

struct Person_s {
    var age = 34, name = "Colin"
    
    mutating func growOlder()
    {
        self.age++
    }
}

func celebrateBirthday(who: Person)
{
    println("Happy Birthday \(who.name)")
    who.growOlder()
}

let person = Person()
celebrateBirthday(person)
println(person.age)



func longestWord(words: String...) -> String?
{
    var currentLongest: String?
    for word in words
    {
        if currentLongest != nil
        {
            if countElements(word) > countElements(currentLongest!)
            {
                currentLongest = word
            }
        }
        else
        {
            currentLongest = word
        }
    }
    return currentLongest
}

let long = longestWord("chick", "fish", "cat", "elephant","donganyuan")

println(long)


func lw(words: String...) -> String?
{
    return words.reduce(String?())
    {
        (longest, word) in
        longest == nil || countElements(word) > countElements(longest!) ? word : longest 
    }
}


func checkAreEqual1(value val:String, expect exp:String, message msg:String)
{
    if exp != val
    {
        println(msg)
    }
}

func checkAreEqual2(#value:String, #expectf:String, #message:String)
{
    if expectf != value
    {
        println(message)
    }
}

checkAreEqual1(value: "1423", expect: "123", message: "hah")

checkAreEqual2(value: "23", expectf: "34", message: "not equal")


class Cell: Printable
{
    private(set) var row = 0
    private(set) var column = 0
    
    func move(x: Int, _ y: Int)
    {
        row += y
        column += x
    }
    
    func moveByX(x: Int)
    {
        column += x
    }
    
    func moveByY(y: Int)
    {
        row += y
    }
    
    var description: String
    {
        get {
            return "Cell [row=\(row), col=\(column)]"
        }
    }
}


var cell = Cell()
var moveFunc = Cell.moveByY
moveFunc(cell)(34)
//cell.moveByX(4)
//cell.move(4, 7)
println(cell.description)


let animals = ["fish", "cat", "chicken", "dog"]

//func isBefore(one: String, two: String) -> Bool
//{
//    return one > two
//}
//
//let sortedStrings = animals.sorted(isBefore)

//let sortedStrings = animals.sorted({
//    (one: String, two: String) -> Bool in
//    return one > two
//})
//

//let sortedStrings = animals.sorted({
//    (one: String, two: String) -> Bool in
//    one > two
//})

//let sortedStrings = animals.sorted({
//    (one, two) in
//    one > two
//})

//let sortedStrings = animals.sorted({
//    one, two in
//    one > two
//})

//let sortedStrings = animals.sorted({
//    $0 > $1
//})

//let sortedStrings = animals.sorted(){
//    $0 > $1
//}

let sortedStrings = animals.sorted(>)


//let sortedStrings = animals.sorted(>)


println(sortedStrings)


typealias StateMachineType = () -> Int

func makeStateMachine(maxState: Int) -> StateMachineType
{
    var currentState: Int = 0
    return {
        currentState++
        if  currentState > maxState {
            currentState = 0
        }
        return currentState
    }
}

let tristate = makeStateMachine(2)
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())

let bistate = makeStateMachine(1)
println(bistate())
println(bistate())
println(bistate())
println(bistate())



//enum_1
//enum Shape: Int {
//    case Rectangle = 10
//    case Square
//    case Triangle
//    case Circle
//}
//
//var aShape: Shape = .Rectangle
//aShape = .Square
//aShape.rawValue
//
//
//var squard = Shape(rawValue: 11)
//var notAShape = Shape(rawValue: 100)





//enum_2
//enum Shape {
//    case Rectangle
//    case Square
//    case Triangle
//    case Circle
//}
//
//var aShape = Shape.Rectangle
//
//switch(aShape){
//    case .Rectangle, .Square:
//        println("This is a quadrilateral")
//    case .Square:
//        println("This is a square")
//    default:
//        break
//}

import UIKit
//enum_3
enum Shape {
    case Rectangle(width:Float, height:Float)
    case Square(side:Float)
    case Triangle(base:Float, height:Float)
    case Circle(radius:Float)
    
    func area() -> Float {
        switch (self) {
        case .Rectangle(let width, let height):
            return width * height
        case .Square(let side):
            return side * side
        case .Triangle(let base, let height):
            return 0.5 * base * height
        case .Circle(let radius):
            return Float(M_PI) * powf(radius, 2)
        }
    }
    
    init (_ rect: CGRect) {
        let width = Float(CGRectGetWidth(rect))
        let height = Float(CGRectGetWidth(rect))
        if width == height {
            self = Square(side: width)
        }
        else
        {
            self = Rectangle(width: width, height: height)
        }

    }
}
var rectangle = Shape.Rectangle(width:5, height:10)

switch (rectangle)
{
    case .Rectangle(let width, let height):
    println("Rectangle: \(width) x \(height)")
default:
    println("Other shape")
}


//switch (rectangle) {
//case .Rectangle(let width, let height) where width <=10:
//    println("Narrow rectangle: \(width) x \(height)")
//case .Rectangle(let width, let height):
//    println("Wide rectangle: \(width) x \(height)")
//default:
//    println("Other shape")
//}





var circle = Shape.Circle(radius: 5)
circle.area()





































