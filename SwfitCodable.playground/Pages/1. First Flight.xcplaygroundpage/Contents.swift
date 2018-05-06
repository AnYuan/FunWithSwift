//: Playground - noun: a place where people can play

import Foundation

let json = """
{
"manufacturer": "Cessna",
"model": "172 Skyhawk",
"seats": 4,
}
""".data(using: .utf8)!

struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
}

let decoder = JSONDecoder()
let plane = try! decoder.decode(Plane.self, from: json)
print(plane.manufacturer)
print(plane.model)
print(plane.seats)


let encoder = JSONEncoder()
let reencodedJSON = try! encoder.encode(plane)
print(String(data: reencodedJSON, encoding: .utf8)!)

let json1 = """
[{
"manufacturer": "Cessna",
"model": "172 Skyhawk",
"seats": 4,
},
{
"manufacturer": "Piper",
"model": "PA-28 Cherokee",
"seats": 4,
}]
""".data(using: .utf8)!

let planes = try! decoder.decode([Plane].self, from: json1)
print(planes)

let json2 = """
{
"planes": [{
    "manufacturer": "Cessna",
    "model": "172 Skyhawk",
    "seats": 4,
    },
    {
    "manufacturer": "Piper",
    "model": "PA-28 Cherokee",
    "seats": 4,
    }]
}
""".data(using: .utf8)!

let keyedPlanes = try! decoder.decode([String:[Plane]].self, from: json2)
print(keyedPlanes["planes"])

struct Fleet: Decodable {
    var planes: [Plane]
}
let fleet = try! decoder.decode(Fleet.self, from: json2)
print(fleet.planes)
