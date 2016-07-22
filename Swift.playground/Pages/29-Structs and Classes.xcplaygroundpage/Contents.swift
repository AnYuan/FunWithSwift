//: [Previous](@previous)

import Foundation
import CoreImage

var str = "Hello, playground"

//: [Next](@next)




//: Copy-On-Write, Efficiently
final class Box<A> {
    var unbox: A
    init(_ value: A) { unbox = value }
}

private var boxedFilter: Box<CIFilter> = {
    var filter = CIFilter(name: "CIGaussianBlur", withInputParameters:[:])!
    filter.setDefaults()
    return Box(filter)
}()


var filter: CIFilter {
    get { return boxedFilter.unbox}
    set { boxedFilter = Box(newValue) }
}

// There is another function, isUniquelyReferenced, which does not
// work on Objective-C types either; even though it accepts Objective-C
// types as input, it always returns false. Both functions share the same
// implementation, but they have different constraints on the input types.

private var filterForWriting: CIFilter {
    get {
        if !isUniquelyReferencedNonObjC(&boxedFilter) {
            filter = filter.copy() as! CIFilter
        }
        return filter
    }
}

// Closures and Mutability
func uniqueIntegerProvider() -> () -> Int {
    var i = 0
    return {
        i += 1
        return i
    }
}


//: Weak References
// A weak reference means that the reference will be nil once the referred object gets deallocated.

//: Unowned References
// A unowned reference means that the reference will not be nil, and the reference is not strongly reference.
// For every unowned reference, the swift runtime keeps a second reference count in the object. when all strong references are gone, the object will release all of its resources. however, the memory of the object itself will still be there until all unowned references are gone too. the memeory is marked as invalid, and anytime we try to access an unowned reference a runtime error will occur.

// There is a third option, unowned(unsafe), which does not have this runtime check. if we access an invalid reference that is marked as unowned(unsafe), we get undefined behavior.

// when you do not need weak, it is recommended that you use unowned. A weak variable always needs to be defined using var, whereas an unowned variable can be defined using let and be immutable. Howerer, only use unowned in situations where you know that the reference will always be valid.


class A {
    unowned(unsafe) let a: NSDate = NSDate()
    unowned(safe) let b: NSString = "2"
    weak var c: NSArray? = nil
}


typealias USDCents = Int
struct Account {
    var fund: USDCents
}

extension Account : CustomStringConvertible {
    var description: String {
        return "Account fund is \(fund)"
    }
}


func transfer(amount: USDCents, source: inout Account, destination: inout Account) -> Bool {
    guard source.fund >= amount else { return false }
    source.fund -= amount
    destination.fund += amount
    return true
}


var alice = Account(fund: 100)
var bob = Account(fund: 0)

transfer(amount: 50, source: &alice, destination: &bob)
alice
bob


//: Closures and Memory
class Example {
    init() { print("init") }
    deinit { print("deinit") }
}

func newScope() {
    _ = Example()
    print("About to leave the scope")
}

newScope()


func capturingScope() -> () -> () {
    let example = Example()
    return { print(example) }
}


let _ = capturingScope()


class ViewController {
    let model = Model()
    let num = 3
    
    func viewDidLoad() {
        model.someClosure = {[unowned self] _ in
            print("\(self.num)")
        }
    }
    
    deinit {
        print("deinit view controller")
    }
}

class Model {
    var someClosure: (number: Int) -> () = {_ in}
    
    deinit {
        print("deinit model")
    }
}


var vc: ViewController? = ViewController()
vc?.viewDidLoad()
vc = nil


//: Case Study: Game Design with Structs
protocol Serializer {
    subscript(name: String) -> PropertyList? { get set }
}

extension UserDefaults: Serializer {
    subscript(name: String) -> PropertyList? {
        get {
            return (object(forKey: name) as? PropertyList)
        }
        set {
            set(newValue, forKey: name)
        }
    }
}

typealias PropertyList = [String: AnyObject]

struct Player {
    var health: Health
    var chocolates: BoxOfChocolates?
    
    init(properties: PropertyList = [:]) {
        let healthProperties = properties["health"] as? PropertyList
        self.health = Health(properties: healthProperties ?? [:])
        if let chocolateProperties = properties["chocolates"] as? PropertyList {
            chocolates = BoxOfChocolates(properties: chocolateProperties)
        }
    }
    
    mutating func study() {
        health.foodPoints -= 2
        health.experiencePoints += 1
    }
    
    func serialize() -> PropertyList {
        var result: PropertyList = [
            "health": health.serialize()
        ]
        result["chocolates"] = chocolates?.serialize()
        return result
    }
}

struct Health {
    var foodPoints: Int = 100
    
    var experiencePoints: Int = 0
    
    init(properties: PropertyList) {
        foodPoints = properties["food"] as? Int ?? foodPoints
        experiencePoints = properties["experience"] as? Int ?? experiencePoints
    }
    
    func serialize() -> PropertyList {
        return [
            "food": foodPoints,
            "experience": experiencePoints
        ]
    }
}

extension Player {
    mutating func eat() {
        guard let count = self.chocolates?.numnberOfChocolates , count > 0 else {
            return
        }
        self.chocolates?.numnberOfChocolates -= 1
        health.foodPoints = min(100, health.foodPoints + 10)
    }
}

struct BoxOfChocolates {
    private var numnberOfChocolates: Int = 10
    
    init(properties: PropertyList) {
        numnberOfChocolates = properties["chocolates"] as? Int ?? numnberOfChocolates
    }
    
    func serialize() -> PropertyList {
        return [
            "chocolates": numnberOfChocolates
        ]
    }
}

class GameState {
    var player: Player {
        didSet { save() }
    }
    var serializer: Serializer
    
    init(serializer: Serializer = UserDefaults.standard) {
        self.serializer = serializer
        player = Player(properties: serializer["player"] ?? [:])
    }
    
    func save() {
        serializer["player"] = player.serialize()
    }
}

