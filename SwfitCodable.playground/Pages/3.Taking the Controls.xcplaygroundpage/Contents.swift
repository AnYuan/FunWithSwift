
import Foundation

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
