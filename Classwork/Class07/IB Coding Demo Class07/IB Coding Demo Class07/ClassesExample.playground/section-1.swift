// Playground - noun: a place where people can play

import UIKit


func repeatString(s: String, n: Int) -> String {
    return "".join(Array(count: n, repeatedValue: s))
}


class Animal {
    var species = ""
    var name = ""
    var emoji = ""
    var noise = ""
    
    init (species: String, name: String) {
        self.species = species
        self.name = name
    }
    
    func stringRepresentation() -> String {
        return repeatString(self.emoji,3) + " This animal is a \(self.species), and its name is \(self.name) " + repeatString(self.emoji,3)
    }
    
    func speak() {
        println(self.noise)
    }
}

class Dog: Animal {
    var isSmart = true
    
    init (name: String) {
        super.init(species: "Dog", name: name)
        self.emoji = "🐶"
        self.noise = "Woof"
    }
    
    override func speak() {
        println("Meow")
    }
}

func printAnimalName(animal: Animal) {
    println("Animal's name is \(animal.name) \(animal.emoji)")
}



var dog = Animal(species: "Dog", name: "Charles")
dog.emoji = "🐶"
printAnimalName(dog)

var otherDog = Dog(name: "Cinder")
printAnimalName(otherDog)
otherDog.speak()
