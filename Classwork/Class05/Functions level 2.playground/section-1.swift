// Playground - noun: a place where people can play

import UIKit

// In0ut parameters let us modify external variables
// The parameter is prefixed with an inout before the parameter declaration on the function. The parameter passed into the function when the function is called is prefixed with a &. Warning: it is not good practice to do this usually.
// ex: func modifyVar(inout myString: String
// ex: modifyVar(&passedparameter)
// Write a function changeName that prints out "Name changed to 'parameter'" and that changes the value of the variable passed to it

func changeName(inout thing: String) {
    thing = "Pants"
    println("Name changed to \(thing)")
}
var x = "not pants"
println(x)
changeName(&x)
println(x)



// Write a function to find the sum of any two multiples below any max value (make the default 2000)
// call sould be something like this: addMultiples(mult1: 3, mult2: 5). answer should be 233,168
func addMultiples(mult: Int, max: Int = 2000) -> Int {
    var total = 0
    var x = mult
    
    while x < max {
        total += x
        x += mult
    }
    
    return total
}
//println(addMultiples(3))
//println(addMultiples(5))
//println(addMultiples(15))


func addSetMultiples(mult1: Int, mult2: Int, max: Int=2000) -> Int {
    return addMultiples(mult1, max: max) + addMultiples(mult2, max: max)
}
//println(addSetMultiples(3, 5))



// Change calculator: write a function that takes a dollar amount and returns the amount of pennies, nickles, dimes, and quarters needed to return as change (if under $1)
func changeCalculator(money: Float) -> (pennies: Int, nickles: Int, dimes: Int, quarters: Int, dollars: Int) {
    var pennies = 0, nickles = 0, dimes = 0, quarters = 0, dollars = 0
    var change: Int
    
    // Dollars
    dollars = Int(floor(money))
    
    // Convert change to an int
    // Need to take the ceiling because subtracting the float
    //  in dollars can result in a value just under what we want
    //  (i.e. instead of 35, we get 34.9999)
    change = Int( ceil((money - Float(dollars)) * 100 ))
    println(change)
    
    // Quarters
    quarters = change / 25
    change -= 25 * quarters
    
    // Dimes
    dimes = change / 10
    change -= 10 * dimes
    
    // Nickles
    nickles = change / 5
    change -= 5 * nickles
    
    // Pennies
    pennies = change
    
    
    return (pennies, nickles, dimes, quarters, dollars)
}
var change = changeCalculator(7.35)
println("Dollars: \(change.dollars), Quarters: \(change.quarters), Dimes: \(change.dimes), Nickles: \(change.nickles), Pennies: \(change.pennies)")



// Variadic parameters are an endless list of parameters that can be passed inside a function. The data inside the function itself is greated as an array. Write a function that takes a parameter describing whether to  multiply or add, and a variadic parameter that represents all the numbers. Return either the sum or the multiplicaiton of the integerss.
// Variadic parameters example: addNumbers(numbers: Int...)

func doMath(mode: String, numbers: Int...) -> Int {
    var total = 0
    
    // Check mode
    if !contains(["add", "multiply"], mode) {
        println("Invalid mode.  Should be \"add\" or \"multiple\"")
        return total
    }

    // Add
    if mode == "add" {
        for val in numbers {
            total += val
        }
    }
    // Multiply
    else {
        total = numbers[0]
        for val in numbers[1..<numbers.count] {
            total *= val
        }
    }
    
    return total
}
println(doMath("add", 1, 2, 3, 4, 5))
println(doMath("multiply", 1, 2, 3, 4, 5))
println(doMath("subtract", 1, 2, 3, 4, 5))



// Closures are self contained blocks that are anonymously defined (similar to blocks in c)
// Functions are a type of named closure
// Closures can be passed around as variables
// A great use for closures is the ability to increment variables/constants. We can return a contained function that returns another value. 
// ex: makeIncrements(incrementAmount: Int) -> () -> int
// Now we can do let myVal = makeIncrements(20). Everytime we run myVal() the return value will increment by the incrementAmount.
// More info on closures: http://fuckingswiftblocksyntax.com/ and https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
// Write a function similar to the one above that gives us the option to either multiply or add, asks us for a base value, and returns a new value everytime we execute the constant/variable

func makeIncrements(incrementAmount: Int) -> () -> Int {
    var myVal = 0
    func increment() -> Int {
        myVal += incrementAmount
        return myVal
    }

    return increment
}
let myVal = makeIncrements(20)
myVal()
myVal()


func addOrMultiply(mode: String, base: Int) -> Int -> Int {
    
    // Check mode
    if !contains(["add", "multiply"], mode) {
        println("Invalid mode.  Should be \"add\" or \"multiple\".  You get a lame function.")

        func doMath(Int) -> Int {
            return 0
        }
        
        return doMath
    }

    var total = base
    
    // Define Add function
    if mode == "add" {
        func doAddition(val: Int) -> Int {
            total += val
            return total
        }
        
        return doAddition
    }
    // Define Multiple Function
    else {
        func doMultiplication(val: Int) -> Int {
            total *= val
            return total
        }
        
        return doMultiplication
    }

}

let myAdd = addOrMultiply("add", 1)
myAdd(4)
myAdd(7)

let myMultiply = addOrMultiply("multiply", 3)
myMultiply(5)
myMultiply(3)

let myLame = addOrMultiply("not add", 7)
myLame(7)
myLame(32)


// The map function is an example of a closure. Use the map function to take an array of names and change the value of each name to "name has been updated".

func updateChipmunks(inout chipmunks: Array<String>) {
    chipmunks = chipmunks.map( {(chipmunk: String) -> String in "\(chipmunk) has been updated)"} )
}

var chipmunks = ["Alvin", "Simon", "Theodore"]
updateChipmunks(&chipmunks)
println(chipmunks)



// Recursion happens when a funciton calls itself from within itself
// Re-write the fibonacci sequence function to use recursion
func nextFib(val1: Int, val2: Int, place: Int) -> Int {
    let newVal = val1 + val2
    
    if place == 1 {
        return newVal
    }
    
    return nextFib(val2, newVal, place-1)
}

func findFibonacci(place: Int) -> Int {
    // Check to make sure the input makes sense
    if place < 1 {
        println("You fail")
        return 37
    }
    // Already know the values for places 1 and 2
    else if place == 1 {
        return 0
    }
    else if place == 2 {
        return 1
    }

    return nextFib(0,1,place-2)
}
findFibonacci(4)
findFibonacci(9)