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
}

extension Cafe: MKAnnotation {
    var title: String! {
        return name
    }
    var coordinate: CLLocationCoordinate2D {
        return location
    }
}