// Playground - noun: a place where people can play

import UIKit

/*
 * This is a comment block
*/

// This is a comment

// Strings are usually presented in double quotes
"This is a string.  8 is a number in a string."

// Integers are whole numbers
5
0
1000000

// Doubles (64 bits) and floats (32 bits)
// Swift uses a double by default
54.76

// Boolean
true
false

// Arrays and dictionaries (also called collections (collections of data)

// Variable: inferred
var myVariable = "Hello world"
println(myVariable)

var mySecondVariable: String = "Hello world again"
mySecondVariable = "hello"

var x = 10.0
var y = 4.0

x + y
x * y
// Integer division
x / y
x - y

x % y


// Constants
let myName = "Tedi"
// myName = "John" will error out because constants are immutable

// Optionals
var amIHere: String? = "Yes"
println(amIHere)
// Unwrap with a bang
amIHere!
// Can only unwrap if there's a value there (should check to see if there's a value before unwrapping)



// ============
// Control Flow
// ============

// == equal to
// <= less than or equal to
// >= greater than or equal to

var a = 5
var b = 5

for a in 1...3 {
    for b in 1...3 {
        if( a == b){
            println("\(a) is \(b)")
        }
        else {
            println("\(a) is not \(b)")
        }

    }
}
println("\n")


for var i = 0; i < 5; ++i {
    println("i = \(i)")
}
println("\n")


// Ranges
for index in 1...5 {
    println("Index is \(index).")
}
println("\n")

for index in 1..<5 {
    println("Index is \(index).")
}
println("\n")


// While loop
var k = 0
while (k < 10) {
    println("k = \(k)")
    ++k
}
println("\n")


// Do while
k = 0
do {
    println("k = \(k)")
} while k < 0
println("\n")

var myAge = 25

for myAge in [15,21,23,32] {
    println("Age is \(myAge)")
    
    if (myAge < 21) {
        println("You can't get in")
    }
    else if (myAge == 21) {
        println("Free drinks, yo.")
    }
    else if (myAge > 21 && myAge < 25) {
        println("You can party, but you can't rent a car")
    }
    else {
        println("You can party.")
    }


    switch myAge {
        case 0..<21:
            println("You can't get in.")

        case 21:
            println("Free drinks, yo.")
        
        case 22..<25:
            println("You can party, but you can't rent a car.")
        
        default:
            println("You can party.")
    }
    
    println("\n")
}



for i in 1...100 {
    if (i%5 == 0 && i%3 == 0) {
        println("FizzBuzz")
    }
    else if (i%3 == 0) {
        println("Fizz")
    }
    else if (i%5 == 0) {
        println("Buzz")
    }
    else {
        println(i)
    }
}




var name: String = "Adam"
var age: Int = 28

let namesAndAges = ["Adam":28, "Phil":13, "Jeff":17, "Frank":19, "Bob":23]

for (name, age) in namesAndAges {
    
    // TODO: Print "Hello {whatever the value of name is}, you are {whatever the value of age is} years old!"
    println("Hello \(name), you are \(age) years old!")
    
    // TODO: Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
    if age >= 21 {
        println("You can drink")
    }
    else if age >= 18 {
        println("You can vote")
    }
    else if age >= 16 {
        println("You can drive")
    }
    else {
        println("You can't do much of anything now, can you?")
    }
    
    // TODO: Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
    if (age >= 16 && age < 18) {
        println("You can drive")
    }
    else if (age >= 18 && age < 21) {
        println("You can drive and vote")
    }
    else if (age >= 21) {
        println("You can drive, vote and drink (but not at the same time!)")
    }
    else {
        println("You're too young")
    }
    
    println("\n")
}
