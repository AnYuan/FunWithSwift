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

