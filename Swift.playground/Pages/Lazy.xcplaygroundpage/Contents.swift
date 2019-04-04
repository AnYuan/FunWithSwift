import Foundation


// Lazy cloures
class Singer {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    lazy var reversedName = {
        return "\(self.name.uppercased()) backwards is \(String(self.name.uppercased().reversed()))!"
    }()
}

// Lazy methods

class MusicPlayer {
    init() {
        print("Ready to play songs!")
    }
}

class Singer1 {
    let name: String
    // all Swift static let singletons are automatically lazy
    static let musicPlayer = MusicPlayer()
    
    init(name: String) {
        self.name = name
    }
    
    lazy var reversedName = self.getReveredName()
    
    private func getReveredName() -> String {
        return "\(self.name.uppercased()) backwards is \(String(self.name.uppercased().reversed()))!"
    }
}


let taylor = Singer1(name: "Taylor Swift")
Singer1.musicPlayer
print(taylor.reversedName)


// Lazy sequences
func fibonacci(of num: Int) -> Int {
    if num < 2 {
        return num
    } else {
        return fibonacci(of: num - 1) + fibonacci(of: num - 2)
    }
}


let fibonacciSequence = (0...20).map(fibonacci)
print(fibonacciSequence[10])


let lazyFibonacciSequence = Array(0...199).lazy.map(fibonacci)
print(lazyFibonacciSequence[19])
print(lazyFibonacciSequence[19])
print(lazyFibonacciSequence[19])

