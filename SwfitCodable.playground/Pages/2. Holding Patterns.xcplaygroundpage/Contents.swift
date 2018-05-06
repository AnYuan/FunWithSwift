
import Foundation

let json = """
{
    "aircraft": {
        "identification": "NA12345",
        "color": "Blue/White"
    },
    "route": ["KTTD", "KHIO"],
    "flight_rules": "VFR",
    "departure_time": {
        "proposed": "2018-04-20T14:15:00-0700",
        "actual": "2018-04-20T14:20:00-0700"
    },
    "remarks": null
}
""".data(using: .utf8)!

struct Aircraft: Decodable {
    var identification: String
    var color: String
}

enum FlightRules: String, Decodable {
    case visual = "VFR"
    case instrument = "IFR"
}

struct FlightPlane: Decodable {
    var aircraft: Aircraft
    var route: [String]
    var flightRules: FlightRules
    private var departureDates: [String: Date]
    var remarks: String?
    
    var proposedDepartureDate: Date? {
        return departureDates["proposed"]
    }
    
    var actualDepartureDate: Date?{
        return departureDates["actual"]
    }
}

extension FlightPlane {
    private enum CodingKeys: String, CodingKey {
        case aircraft
        case flightRules = "flight_rules"
        case route
        case departureDates = "departure_time"
        case remarks
    }
}

var decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
decoder.dateDecodingStrategy = .iso8601

let plan = try! decoder.decode(FlightPlane.self, from: json)

print(plan.aircraft.identification)
print(plan.actualDepartureDate!)





