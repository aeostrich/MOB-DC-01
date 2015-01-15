//
//  Animal.swift
//  IB Coding Demo Class07
//
//  Created by Adam Ostrich on 1/14/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

/*
‣ In pairs, create a class called “Animal”
‣ It should have two strings as instance variables, species and name
‣ It should have one method, stringRepresentation, which should return
‣ “The animal is a {species}, its name is {name}
    ‣ Create a view controller with two buttons and a text field
    ‣ One button creates a cat, the other creates a dog. You pick the name
‣ When the button is clicked, the label should display the results of stringRepresentation for a new instance of Animal

*/

func repeatString(s: String, n: Int) -> String {
        return "".join(Array(count: n, repeatedValue: s))
}


class Animal {
        var species = ""
        var name = ""
        var emoji = ""
        
        init (species: String, name: String) {
            self.species = species
            self.name = name
        }
        
        func stringRepresentation() -> String {
            return repeatString(self.emoji,3) + " This animal is a \(self.species), and its name is \(self.name) " + repeatString(self.emoji,3)
        }
}