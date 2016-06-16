//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Deinitialization
/*:
A deinitializer is called immediately before a class instance is deallocated. Deinitializers are only available on class types.
*/

/*:
Class definitions can have at most one deinitializer per class. The deinitializer does not take any parameters and is written without parentheses:
deinit {
    //perform the deinitialization
}

Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.

A deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties.
*/

struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(_ numberOfCoinsToVend: Int) -> Int {
        var numberOfCoinsToVend = numberOfCoinsToVend
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(_ coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(_ coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

