//
//  MyLocations.swift
//  MyLocations
//
//  Created by Jesse Pruitt on 5/11/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation
import CoreData

class MyLocations: NSManagedObject {

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var date: NSTimeInterval
    @NSManaged var locationDescription: String
    @NSManaged var category: String
    @NSManaged var placemark: AnyObject

}
