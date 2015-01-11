// Playground - noun: a place where people can play

import UIKit

func hello() {
    println("'Sup")
}

hello()
hello()


func sum(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

sum(1,2)
sum(4,5)

// func fib(fibNum num: Int) -> Int
// Only use # if the external and internal names are the same
func fib(#num: Int) -> Int {
    if num == 1 {
        return 0
    }
    else if num == 2 {
        return 1
    }
    else if num <= 0 {
        println("That's not a thing.  I'll give you -1")
        return -1
    }
    
    var num1 = 0, num2 = 1
    for i in 3...num {
        (num1, num2) = (num2, num1 + num2)
    }
    return num2
}
println(fib(num:   9))
println(fib(num:  30))
println(fib(num: -37))

// If you want a parameter to be optional, make it an optional (hahaha)
func pants(myPants: Int?) -> Int {
    // Note: You don't have to unwrap thing1
    if let thing1 = myPants {
        return thing1
    }
    else {
        return 7
    }
}
println(pants(8))
println(pants(nil))

// Multiple return values
func pickles() -> (one: Int, two: Int) {
    return (1, 2)
}
var x = pickles()
println(x.one)
println(x.two)

var y = split("My Pants") {$0 == " "}
println(y)

