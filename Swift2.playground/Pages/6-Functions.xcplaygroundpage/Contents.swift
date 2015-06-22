//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func sayHello(personName: String) -> String {
    return "Hello, " + personName + "!"
}

sayHello("anyuan")


//Function Parameters and Return Values

//Multiple Input Parameters
func halfOpenRangeLength(start start: Int, end: Int) -> Int {
    return end - start
}

print(halfOpenRangeLength(start: 1, end: 10))

//Default Parameter Values
/*
Place parameters with default values at the end of a function's
parameter list. This ensures that all calls to the function use
the same order for their nondefault arguments, and makes it clear
that the same function is being called in each case.
*/
func someFunction(parameterWithDefault: Int = 12) {
    print("value is \(parameterWithDefault)")
}

someFunction()

someFunction(5)

func twoDefaultParameters(parameterOne: Int = 1, parameterTwo: Int = 2) {
    print("one is \(parameterOne) and two is \(parameterTwo)")
}

twoDefaultParameters()
twoDefaultParameters(3,parameterTwo: 4)


//In-Out Parameters
/*
In-out parameters cannot have default values, and variadic parameters
cannot be marked as inout. If you mark a parameter as inout, it cannot
also be marked as var or let.
*/

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 108
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt


//Function Types as Return Types
func stepForward(input: Int) -> Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}


var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")




























































