// Playground - noun: a place where people can play

import UIKit

class Animal {
    var legs: Int
    var hasFur: Bool = true
    var hasClaws: Bool
    
    init(hasClaws: Bool) {
        self.hasClaws = hasClaws
        self.legs = 4
    }
    
    func speak() {
        println("Hello world")
    }
}

class Dog: Animal {
    
}