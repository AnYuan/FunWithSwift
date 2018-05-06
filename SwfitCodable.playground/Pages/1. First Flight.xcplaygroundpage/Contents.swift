//: Playground - noun: a place where people can play

import Foundation

let json = """
{
"manufacturer": "Cessna",
"model": "172 Skyhawk",
"seats": 4,
}
""".data(using: .utf8)!

struct Plane: Decodable {
    var manufacturer: String
    var model: String
    var seats: Int
    
    private enum CodingKeys: String, CodingKey {
        case manufacturer
        case model
        case seats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.model = try container.decode(String.self, forKey: .model)
        self.seats = try container.decode(Int.self, forKey: .seats)
    }
}

let decoder = JSONDecoder()
let plane = try! decoder.decode(Plane.self, from: json)
print(plane.manufacturer)
print(plane.model)
print(plane.seats)


