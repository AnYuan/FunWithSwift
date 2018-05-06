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
    
    private enum CodingKeys: String, CodingKey {
        case manufacturer
        case model
        case seats
    }
    
    //Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.model = try container.decode(String.self, forKey: .model)
        self.seats = try container.decode(Int.self, forKey: .seats)
    }
    
    //Encodable
    func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.manufacturer, forKey: .manufacturer)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.seats, forKey: .seats)
    }
}

let decoder = JSONDecoder()
let plane = try! decoder.decode(Plane.self, from: json)
print(plane.manufacturer)
print(plane.model)
print(plane.seats)


let encoder = JSONEncoder()
let reencodedJSON = try! encoder.encode(plane)
print(String(data: reencodedJSON, encoding: .utf8)!)

