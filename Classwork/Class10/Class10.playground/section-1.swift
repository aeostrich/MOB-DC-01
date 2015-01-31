// Playground - noun: a place where people can play

import UIKit

var myArray = [1, 4, 10, 15, 20]

var secondArray: [Int] = []

var stringArray: [String] = []

myArray[2]

myArray.first
myArray.last

secondArray.append(20)
secondArray

// Insert pushes current array elements to the right to make room
myArray.insert(100, atIndex: 2)
myArray.count
myArray.insert(50, atIndex: myArray.count - 1)
myArray.isEmpty
stringArray.isEmpty
myArray[1] = 40
myArray
myArray.removeAtIndex(2)

for i in myArray {
    if i == 15 {
        println("BINGO")
    }
    else {
        println("The value is \(i)")
    }
}

var crazy: [[Int]] = []
crazy.append([5])
crazy.append([6])
crazy[0]




protocol Animal {
    var pants: Int {get set}
}

class Dog: Animal {
    var pants = 7
    var notPants = 5
}

var dog = Dog()

var ptr: Animal?
ptr = dog

ptr?.pants