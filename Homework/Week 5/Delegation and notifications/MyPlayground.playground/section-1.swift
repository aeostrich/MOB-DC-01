// Playground - noun: a place where people can play

import UIKit

var dict: [String:Int] = [:]
dict["Pants"] = 3
dict["Yo"] = 7
dict["Not Pants"] = 14
var x: [(String, Int)]
x = map(dict) { (key, value) in (key, value)}
x[0].0
x[0].1

