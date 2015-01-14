// Playground - noun: a place where people can play

import UIKit

class Animal {
    var numberOfLegs: Int
    var hasFur = true
    var sound = "silence"
    
    init(legs: Int, hasFur: Bool) {
        self.numberOfLegs = legs
        self.hasFur = hasFur
    }
    
    func speak() {
        println(self.sound)
    }
    
}

class Human: Animal {
    init() {
        super.init(legs: 2, hasFur: false)
        self.sound = "'sup"
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4, hasFur: true)
        self.sound = "bark"
    }
}


var adam = Human()
println(adam.hasFur)
println(adam.numberOfLegs)
adam.speak()


var charlie = Dog()
println(charlie.hasFur)
println(charlie.numberOfLegs)
charlie.speak()
