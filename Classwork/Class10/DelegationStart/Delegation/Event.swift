//
//  Event.swift
//  Delegation
//
//  Created by Thomas Degry on 29/01/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import Foundation

struct Event {
    var name:String
    var location:String
    
    init (name: String, location: String) {
        self.name = name
        self.location = location
    }
}