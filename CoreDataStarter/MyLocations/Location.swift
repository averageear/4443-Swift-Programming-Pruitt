//
//  Location.swift
//  MyLocations
//
//  Created by Jesse Pruitt on 5/11/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation


class Location: NSManagedObject {
    
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var date: NSDate
    @NSManaged var locationDescription: String
    @NSManaged var category: String
    @NSManaged var placemark: CLPlacemark?
    
}