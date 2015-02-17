//
//  Cafe.swift
//  CafeHunter
//
//  Created by Anyuan on 15/2/17.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation
import MapKit

class Cafe: NSObject {
    let fbid: String
    let name: String
    let location: CLLocationCoordinate2D
    let street: String
    let city: String
    let zip: String
    
    init(fbid: String, name: String,
        location: CLLocationCoordinate2D,
        street: String, city: String, zip: String)
    {
        self.fbid = fbid
        self.name = name
        self.location = location
        self.street = street
        self.city = city
        self.zip = zip
        
        super.init()
    }
    
    class func fromJSON(json: [String:JSONValue]) -> Cafe? {
        let fbid = json["id"]?.string
        let name = json["name"]?.string
        let latitude = json["location"]?["latitude"]?.double
        let longitude = json["location"]?["longitude"]?.double
        
        if fbid != nil && name != nil && latitude != nil && longitude != nil {
            var street: String
            if let maybeStreet = json["location"]?["street"]?.string {
                street = maybeStreet
            } else {
                street = ""
            }
            
            var city: String
            if let maybeCity = json["location"]?["city"]?.string {
                city = maybeCity
            } else {
                city = ""
            }
            
            var zip: String
            if let maybeZip = json["location"]?["zip"]?.string {
                zip = maybeZip
            } else {
                zip = ""
            }
            
            let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            return Cafe(fbid: fbid!, name: name!, location: location, street: street, city: city, zip: zip)
        }
        return nil
    }

}

extension Cafe: MKAnnotation {
    var title: String! {
        return name
    }
    var coordinate: CLLocationCoordinate2D {
        return location
    }
}