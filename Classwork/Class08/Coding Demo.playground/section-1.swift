// Playground - noun: a place where people can play

import UIKit

// =========
// Protocols
// =========

// Enforces rules for certain properties and methods
// Enforces structure

protocol Flight {
    // get/set allows us to pull and overwrite the property
    // Defining that the property has get and set permissions
    // Can also just define get if you don't want the object to have
    //  access to set the variable
    var hasWings: Bool { get set }
}

protocol Talk {
    func speak() -> String
}

class Penguin: Animal, Flight, Talk {
    var hasWings: Bool = true
    
    func speak() -> String {
        return "Penguin-y noises..."
    }
}


class Animal {
    var legs: Int
    var hasFur: Bool = true
    var hasClaws: Bool
    
    init(hasClaws: Bool, legs: Int) {
        self.hasClaws = hasClaws
        self.legs = legs
    }
    
    func speak() {
        println("Hello world")
    }
    
    func describeAnimal() {
        println("This animal has \(self.legs) legs")
    }
}

class Dog: Animal {
    
    /*
    // Cannot override stored properties
    // Properties has two stages: 1) set property and 2) read property
    // override var fur = true
    
    // Need to use get/set
    override var hasFur: Bool {
        get {
            // Return whatever the fur variable is set as
            return super.hasFur
        }
        set {
            // override the inherited property to the new value set by the sub class
            super.hasFur = newValue
        }
    }
    */
    
    override func speak() {
        super.speak()
        println("Woof woof")
    }
}

var frank = Dog(hasClaws: true, legs: 3)
frank.speak()



// =======
// Structs
// =======

// While structs can have functions, the functions are associated to the struct in the code syntax
// The actual struct in memory is not in any way related to the functions it contains
struct Rectangle {
    var width: Int
    var height: Int
    
    func getArea() -> Int {
        return width * height
    }
}


let myRectangle = Rectangle(width: 50, height: 100)
myRectangle.getArea()

var otherRectangle = myRectangle
otherRectangle.width = 70
myRectangle.width