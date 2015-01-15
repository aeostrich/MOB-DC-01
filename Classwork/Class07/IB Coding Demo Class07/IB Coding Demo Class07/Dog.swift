//
//  Dog.swift
//  IB Coding Demo Class07
//
//  Created by Adam Ostrich on 1/14/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

class Dog: Animal {
    init (name: String) {
        super.init(species: "Dog", name: name)
        self.emoji = "🐶"
    }
}