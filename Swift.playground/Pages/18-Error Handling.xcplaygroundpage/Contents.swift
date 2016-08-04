//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//:Error Handling
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(required: Double)
    case outOfStock
}

//:Throwing Errors
//func canThrowErrors() throws -> String
//func cannotThrowErrors() -> String

struct Item {
    var price: Double
    var count: Int
}

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.75, count: 11)
]

var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.invalidSelection
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.outOfStock
    }
    
    if amountDeposited >= item.price {
        amountDeposited -= item.price
        item.count -= 1
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.insufficientFunds(required: amountRequired)
    }
}

/*:
a guard statement is used to bind the item constant and count variable to the corresponding values in the current inventory. if the item is not in the inventory, the InvalidSelection error is thrown.
*/
let favoriteSnacks = [
    "Alice":"chips",
    "Bob":"Licorice",
    "Eve":"Pretzels"
]
func buyFavoriteSnack(_ person: String) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vend(itemNamed: snackName)
}

//:Catching and handling Errors
//do {
//    try function that throws
//    statements
//} catch pattern {
//    statements
//}

do {
    try vend(itemNamed: "Candy Bar")
} catch VendingMachineError.invalidSelection {
    print("Invalid selection")
} catch VendingMachineError.outOfStock {
    print("out of stock.")
} catch VendingMachineError.insufficientFunds(let amountRequired) {
    print("insufficent funds")
}

//:Disabling Error Propagation
/*:
There are some cases in which you know a throwing function or method won't, in fact, throw an error at run time. In these cases, you can call the throwing function or method in a forced-try expression, written, try!, instead of a regular try expression.

Calling a throwing function or method with try! disables error propagation and wraps the call in a run-time assertion that no error will be thrown. If an error actually is thrown, you'll get a runtime error.
*/


//:Specifying Clean-up actions
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            /* work with the file */
//        }
//        //close(file) is called here, at the end of the scope.
//    }
//}







