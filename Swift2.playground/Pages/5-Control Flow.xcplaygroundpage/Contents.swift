//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Early Exit
/*
A guard statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an else clause --- the code inside the else clause is executed if the condition is not true.
*/

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weatcher is nice in \(location).")
}

greet(["name":"John"])


//Checking API Availability
/*

*/
if #available(iOS 9, OSX 10.10, *) {
    
} else {
    
}