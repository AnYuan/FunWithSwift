//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Optional Chaining
//:Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.

//:Optional Chaining as an Alternative to Forced Unwrapping
//:The main difference between Optional Chaining and forced unwrapping is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("\(roomCount)")
} else {
    print("noooooooooo")
}

//:Defining Model Classes for Optional Chaining
class Person_new {
    var residence: Residence_new?
}

class Residence_new {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("the number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {self.name = name}
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

let mike = Person_new()
if let roomCount = mike.residence?.numberOfRooms {
    print("has \(roomCount) rooms.")
} else {
    print("nooooooooooo");
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.buildingName = "Acacia Road"
mike.residence?.address = someAddress

/*:methods with no return type have an implicit return type of Void.
if you call this method on an optional value with optional chaining, the method's return type will be Void?, not Void.
*/

if mike.residence?.printNumberOfRooms() != nil {
    print("can print")
} else {
    print("can not print")
}

if (mike.residence?.address = someAddress) != nil {
    print("can set address")
} else {
    print("can not set address")
}

//:Accessing Subscripts Through Optional Chaining
if let firstRoomName = mike.residence?[0].name {
    print("first room name is \(firstRoomName)")
} else {
    print("noooooooôöòóœ")
}

mike.residence?[0] = Room(name:"Bathroom")

let mikesHouse = Residence_new()
mikesHouse.rooms.append(Room(name:"Living Room"))
mikesHouse.rooms.append(Room(name:"Kitchen"))
mike.residence = mikesHouse

if let firstRoomName = mike.residence?[0].name {
    print("\(firstRoomName)")
} else {
    print("nooooooooo")
}

//:Accessing Subscripts of Optional Type
var testScrores = ["Dave":[86,82,84], "Bev":[79,94,81]]
testScrores["Dave"]?[0] = 91
testScrores["Bev"]?[0]++
testScrores["Brain"]?[0] = 82

//:Linking Multiple Levels of Chaining
if let mikesStreet = mike.residence?.address?.street {
    print("hahahah")
} else {
    print("nooooooo")
}



















