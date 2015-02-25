// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var wayneGretzky = ["first_name": "Wayne", "last_name": "Gretzky", "team": "Capitals"]

if let firstName = wayneGretzky["first_name"] {
    println(firstName)
}

var ena: [String: Int] = [:]

// Set values in dict
ena["legs"] = 4
ena["eyes"] = 2

// Setting a value to nil removes it from the dictionary
ena["wings"] = 7
ena["wings"] = nil
ena

// Can also use removeValueForKey
ena["pincers"] = 14
ena.removeValueForKey("pincers")

ena["paws"] = 4


// Iterate through key/value pairs
for (key, value) in ena {
    println("Ena has \(value) \(key)")
}

// Iterate through keys
for enaKey in ena.keys {
    println(enaKey)
}

// Iterate through values
for enaValue in ena.values {
    println(enaValue)
}


var articles = [
    ["title": "Ena breaks tail", "date": "02/23/15", "author": "tedi"],
    ["title": "MOB class does Core Data", "date": "02/25/15", "author": "Arthur"]
]

articles[1]["title"]

for article in articles {
    println(article["title"]!)
}

