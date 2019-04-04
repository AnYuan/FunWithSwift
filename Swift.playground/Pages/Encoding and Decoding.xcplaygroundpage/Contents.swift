import Foundation

struct Coordinate: Codable, Equatable {
    var latitude: Double
    var longitude: Double
}

struct Placemark: Codable, Equatable {
    var name: String
    var coordinate: Coordinate
}


// Encoding
let places = [Placemark(name: "Berlin", coordinate: Coordinate(latitude: 52, longitude: 13)), Placemark(name: "Cape Town", coordinate: Coordinate(latitude: -34, longitude: 18))]

//do {
//    let encoder = JSONEncoder()
//    let jsonData = try encoder.encode(places)
//    let jsonString = String(decoding:jsonData, as: UTF8.self)
//} catch {
//    print(error.localizedDescription)
//}

let encoder = JSONEncoder()
let jsonData = try encoder.encode(places)
let jsonString = String(decoding:jsonData, as: UTF8.self)

// Decoding

do {
    let decoder = JSONDecoder()
    let decoded = try decoder.decode([Placemark].self, from:jsonData)
    type(of:decoded)
    decoded == places
} catch {
    print(error.localizedDescription)
}
