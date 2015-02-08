// Playground - noun: a place where people can play

import UIKit

func increment(numInt: Int) -> Int {
    return numInt + 1
}

func increment(numStr: String) -> String {
    if let val = numStr.toInt() {
        return String(val + 1)
    }
    else {
        return "pants"
    }
}

println(increment(5))
println(increment("5"))
println(increment("five"))
