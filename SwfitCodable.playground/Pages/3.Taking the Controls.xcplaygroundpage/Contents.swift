
import Foundation

//decoding unknown keys

let json = """
{
    "points": ["KSQL", "KWVI"],
    "KSQL": {
        "code": "KSQL",
        "name": "San Carlos Airport"
    },
    "KWVI": {
        "code": "KWVI",
        "name": "Watsonville Municipal Airport"
    }
}
""".data(using: .utf8)!

struct Route: Decodable {
    struct Airport: Decodable {
        var code: String
        var name: String
    }
    
    var points: [Airport]
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        static let points = CodingKeys(stringValue: "points")!
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var points: [Airport] = []
        let codes = try container.decode([String].self, forKey: .points)
        
        for code in codes {
            let key = CodingKeys(stringValue: code)!
            let airport = try container.decode(Airport.self, forKey: key)
            points.append(airport)
        }
        self.points = points
    }
}

let decoder = JSONDecoder()
let route = try! decoder.decode(Route.self, from: json)
print(route)

//Decoding indeterminate types
let json1 = """
[
    {
        "type": "bird",
        "genus": "Chaetura",
        "species": "Vauxi"
    },
    {
        "type": "plane",
        "identifier": "NA12345"
    }
]
""".data(using: .utf8)!

struct Bird: Decodable {
    let genus: String
    let species: String
}

struct Plane: Decodable {
    let identifier: String
}

enum Either<T, U> {
    case left(T)
    case right(U)
}

extension Either: Decodable where T: Decodable, U: Decodable {
    init(from decoder: Decoder) throws {
        if let value = try? T(from: decoder) {
            self = .left(value)
        } else if let value = try? U(from: decoder) {
            self = .right(value)
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot decode \(T.self) or \(U.self)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

let decoder1 = JSONDecoder()
let objects = try! decoder1.decode([Either<Bird, Plane>].self, from: json1)

for object in objects {
    switch object {
    case .left(let bird):
        print("Poo-tee-weet? It's \(bird.genus) \(bird.species)")
    case .right(let plane):
        print("Vooooooooooo! It's \(plane.identifier)")
    }
}

//decoding inherited types
class EconomySeat: Decodable {
    var number: Int
    var letter: String
}

class PremiumEconomySeat: EconomySeat {
    var mealPreference: String?
    
    private enum CodingKeys: String, CodingKey {
        case mealPreference
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealPreference = try container.decode(String.self, forKey:.mealPreference)
        try super.init(from: decoder)
    }
}

//Configuring How Encodable Types Are Represneted
struct Pixel {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
}

extension Pixel: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch encoder.userInfo[.colorEncodingStrategy] as? ColorEncodingStrategy {
        case let .hexadecimal(hash)?:
            try container.encode((hash ? "#" : "") + String(format: "%02X%02X%02X", red, green, blue))
        default:
            try container.encode(String(format: "rgb(%d, %d, %d)", red, green, blue))
        }
    }
}

enum ColorEncodingStrategy {
    case rgb
    case hexadecimal(hash: Bool)
}

extension CodingUserInfoKey {
    static let colorEncodingStrategy = CodingUserInfoKey(rawValue: "colorEncodingStrategy")!
}

let encoder = JSONEncoder()
encoder.userInfo[.colorEncodingStrategy] = ColorEncodingStrategy.hexadecimal(hash: true)

let cyan = Pixel(red: 0, green: 255, blue: 255)
let magenta = Pixel(red: 255, green: 0, blue: 255)
let yellow = Pixel(red: 255, green: 255, blue: 0)
let black = Pixel(red: 0, green: 0, blue: 0)

let json2 = try! encoder.encode([cyan, magenta, yellow, black])
print(String(data: json2, encoding: .utf8)!)


//AnyCodable
//https://github.com/Flight-School/AnyCodable
