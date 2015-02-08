// Playground - noun: a place where people can play
// Lesson 05

// Complete these, in order, writing code under each TODO statement. Each statement calls for a function to be written, write each of them and then immediately call it after the function definition.

// TODO: Write a function that prints out "Hello world!" 10 times
func hi() {
    for i in 1...10 {
        println("Hello World")
    }
}

// TODO: Write a function that prints out "Hit this line {number of iterations of the loop} times!" 20 times
func loop(num: Int) {
    for i in 1...num {
        println("Hit this line \(i) times!")
    }
}
loop(20)

// TODO: Write a function that accepts a string as a parameter. Print "Hello {value of string}!"
func sup(thing: String) {
    println("Hello \(thing)")
}
sup("Pickles")

// TODO: Write a function accepts a string optional. If the string optional exists, print "Hello {value of string}!". If it doesn't, print "Hello world!"
func maybe(thing: String?=nil) {
    if let name = thing {
        println("Hello \(name)")
    }
    else {
        println("Hello world!")
    }
}
maybe()
maybe(thing: "Pants")

// TODO: Write a function that takes one parameter, n, and returns an integer, the nth series in the fibonacci
// sequence. The first fibonacci number is 0, the second is 1, the third is 1, the fourth is 2, fifth is 3, sixth is 5, etc. fibonacci numbers at sequence n are the sum of the n-1 and n-2 fibonacci number.
func fib(#n: Int) -> Int {
    if n == 1 {
        return 0
    }
    else if n == 2 {
        return 1
    }
    else if n <= 0 {
        println("That's not a thing.  I'll give you -1")
        return -1
    }
    
    var num1 = 0, num2 = 1
    for i in 3...n {
        (num1, num2) = (num2, num1 + num2)
    }
    return num2
}
println(fib(n:   9))
println(fib(n:  30))
println(fib(n: -37))


// TODO: Write a function that calls the above function in order to print the sum of the first 20 fibonacci numbers.
func fibSum(times: Int) {
    var sum = 0
    for i in 1...times {
        sum += fib(n: i)
    }
    println(sum)
}
fibSum(20)

// TODO: Write a function that takes in a number and prints out whether it is prime, composite or neither.
func prime(num: Int) -> Bool {
    if num <= 1 {
        return false
    }
    else if contains([2,3], num) {
        return true
    }
    
    for i in 2...(num/2) {
        for j in 2...(num/2) {
            if i*j == num {
                return false
            }
        }
    }
    
    return true
}

func eval(num: Int) {
    if num <= 1 {
        println("The number \(num) is neither composite nor prime")
    }
    else if prime(num) {
        println("The number \(num) is prime")
    }
    else {
        println("The number \(num) is composite")
    }
}
eval(-3)
eval(23)
eval(25)


// TODO: Write a function that prints out each of the first 20 fibonacci numbers and whether they are prime. (e.g. 0 is not prime or composite, 1 is prime, etc)
func fibVals(num: Int) {
    for i in 1...num {
        let val = fib(n: i)
        eval(val)
    }
}
//fibVals(20)

// TODO: Write a function that takes in two numbers, a bill amount and an optional tip percentage (represented as a float, e.g. .2 = 20% tip). Return a tuple with the total bill amount and the tip amount (if included).
func tipCalculate(bill: Float, tip: Float? = nil) -> (total: Float, tip: Float) {
    var tipAmount: Float = 0.0
    if let percent = tip {
        tipAmount = percent * bill
    }
    
    return (bill + tipAmount, tipAmount)
}
var x = tipCalculate(42.73, tip: 0)
println("Total is \(x.total), tip is \(x.tip)")

var y = tipCalculate(19.50)
println("Total is \(y.total), tip is \(y.tip)")

var z = tipCalculate(33.96, tip: 0.15)
println("Total is \(z.total), tip is \(z.tip)")


// TODO: Write a function that takes in a string and returns a string that is the reverse of the input. Append two strings using the + operator.
func rev(pants: String) -> String {
    var out: String = ""
    for c in pants {
        out = String(c) + out
    }
    return out
}
println(rev("Things and stuff!"))


// BONUS TODO: Write a function that takes in an array of strings and a search term string. Return a boolean indicating whether the search term string exists in the array.
func isIn(arr: Array<String>, term: String) -> Bool {
    return contains(arr, term)
}
var list = ["pants", "notpants"]
println(isIn(list, "pants"))
println(isIn(list, "Pickles"))

// BONUS TODO: Write a function that accepts a string and returns a boolean indicating whether a string is a palindrome (reads the same backwards or forwards).
func isPalindrome(thing: String) -> Bool {
    return thing == rev(thing)
}
isPalindrome("racecar")
isPalindrome("pants")

// BONUS TODO: Write a function that takes in two strings and returns a boolean indicating whether the two strings are equivalent

func stringsAreSame(string1: String, string2: String) -> Bool {
    return string1 == string2
}

println(stringsAreSame("pants", "pants"))
println(stringsAreSame("pants", "notpants"))

// BONUS TODO: Write a function that accepts two parameters, a string and a function that accepts a string and returns a string. Print the result of passing the string into the function 10 times.
func pass(thing: String, fun: (String) -> String) {
    var newThing = thing
    for i in 1...20 {
        newThing = fun(newThing)
        println(newThing)
    }
}
pass("pants", rev)
