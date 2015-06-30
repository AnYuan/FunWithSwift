//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*:
# Closures Three forms:
* Global Functions are closures that have a name and do not capture any values.
* Nested functions are closures that have a name and can capture values from their enclosing function.
* Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
*/
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversed = names.sort(backwards)

reversed = names.sort({(s1: String, s2: String) -> Bool in
    return s1 > s2
})

//: Inferring Type From Context
reversed = names.sort({s1, s2 in return s1 > s2})

//: Implicit Returns from single-expression closures
reversed = names.sort({s1, s2 in s1 > s2})

//: Shorthand Argument Names
reversed = names.sort({$0 > $1})

//: Operator Functions
reversed = names.sort(>)

//: Trailing Closures
func someFunctionThatTakesAClosure(closure:() -> Void) {
    //function body goes here
}

//here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure({
    //closure's body goes here
})


//here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    //trailing closure's body goes here
}

reversed = names.sort(){
    $0 > $1
}

reversed = names.sort{
    $0 > $1
}

let digitNames = [0:"zero", 1:"one", 2:"two", 3:"three", 4:"four",
    5:"five", 6:"six", 7:"seven", 8:"eight", 9:"nine"]
let numbers = [16,58,510]
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

//:Capturing Values
//:nested function
func makeIncrementer(forIncrement amount: Int) -> Void -> Int
{
    var runningTotal = 0
    
    func incrementer() -> Int
    {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

var someInt = incrementByTen()
someInt = incrementByTen()
someInt = incrementByTen()

//: Closures Are Reference Types







































