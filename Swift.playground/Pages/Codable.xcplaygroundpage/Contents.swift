import Foundation
import CoreLocation


// Making Types you don't own codable

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

// Brute force
struct Placemark: Codable {
    var name: String
    var coordinate: CLLocationCoordinate2D
}

extension Placemark {
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(name, forKey:.name)
        try container.encode(coordinate.latitude, forKey:.latitude)
        try container.encode(coordinate.longitude, forKey:.longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey:.name)
        self.coordinate = CLLocationCoordinate2D(latitude: try container.decode(Double.self, forKey:.latitude), longitude:try container.decode(Double.self, forKey:.longitude))
    }
}

// The Computed Property Workaround
struct Placemark1: Codable {
    var name: String
    private var _coordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude:_coordinate.latitude, longitude:_coordinate.longitude)
        }
        set {
            _coordinate = Coordinate(latitude:newValue.latitude, longitude:newValue.longitude)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case _coordinate = "coordinate"
    }
}
