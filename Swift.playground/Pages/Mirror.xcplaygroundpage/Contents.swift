import Foundation

protocol DogBreed {
    typealias Level = Int
    
    var breedName: String { get set }
    var size: Level { get set }
    var health: Level { get set }
    var adaptability: Level { get set }
    var intelligence: Level { get set }
    var dogType: DogType { get set }
}

enum DogType: String {
    case companion = "companion"
    case sled = "sled dog"
}

class SiberianHusky: DogBreed {
    var breedName: String
    var size: Level
    var health: Level
    var adaptability: Level
    var intelligence: Level
    var dogType: DogType
    
    init() {
        self.breedName = "Husky"
        self.size = 3
        self.health = 4
        self.adaptability = 3
        self.intelligence = 3
        self.dogType = .sled
    }
}

class Pomsky: SiberianHusky {
    override init() {
        super.init()
        self.breedName = "Pomsky"
        self.size = 2
        self.dogType = .companion
    }
}


let husky = SiberianHusky()
let huskMirror = Mirror(reflecting: husky)

for case let (label?, value) in huskMirror.children {
    print(label, value)
}


extension Pomsky: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(Pomsky.self, children: ["name": self.breedName , "size": self.size, "type" : self.dogType], displayStyle: .class, ancestorRepresentation: .generated)
    }
}

let pomsky = Pomsky()
let pomskyMirror = Mirror(reflecting: pomsky)
for case let (label?, value) in pomskyMirror.children {
    print(label, value)
}

class DogOwner {
    var name: String
    var dog: DogBreed
    private let age: Int
    
    init(name: String, dog: DogBreed) {
        self.name = name
        self.dog = dog
        self.age = 1
    }
    
    func test() -> Void {
        
    }
}

let owner = DogOwner(name: "Pete", dog: husky)
let ownerMirror = Mirror(reflecting: owner)
print ("Pete owns a \(ownerMirror.descendant("dog", "breedName") ?? "some dog")")
print ("Pete owns a \(ownerMirror.descendant("age") ?? "some dog")")


dump(owner)

