//
//  Cat.swift
//  IB Coding Demo Class07
//
//  Created by Adam Ostrich on 1/14/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

class Cat: Animal {
    init (name: String) {
        super.init(species: "Cat", name: name)
        self.emoji = "🐱"
    }
}