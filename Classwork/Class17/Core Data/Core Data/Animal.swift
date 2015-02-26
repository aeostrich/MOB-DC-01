//
//  Animal.swift
//  Core Data
//
//  Created by Adam Ostrich on 2/25/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation
import CoreData

// Creates bridge from our class into Objective C
@objc(Animal)

class Animal: NSManagedObject {
    // @NSManaged indicates that it's a managed attribute
    //  that doesn't need an initial value
    @NSManaged var hasFur: Bool
    @NSManaged var name: String
    @NSManaged var noise: String
    @NSManaged var numberOfLegs: Int32
}