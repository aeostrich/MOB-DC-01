// Playground - noun: a place where people can play

import UIKit
// Have to add asynchronous functionality to playground
import XCPlayground

// Let asynchronous code run
XCPSetExecutionShouldContinueIndefinitely()

// Returns an optional because it verifies that the format is a valid url
// Only analyzes the string, does not perform a DNS query
let url = NSURL(string: "http://tedi.io")

// Completion handler options are arbitrary
// Just defines the variables within the scope of the closure
let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
    println(data)
    println(response)
    println(error)
})

task.resume()