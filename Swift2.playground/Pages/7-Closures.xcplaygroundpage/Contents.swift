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
