// Playground - noun: a place where people can play

import UIKit

class Vehicle {
    var wheels = 0
    var name = ""
    var color = ""
    var numberOfSeats = 0
    var numberOfAxels = 0
    
    func go() {
        println("Vroom vroom")
    }
    
    func inspectCar() {
        println("This car has \(self.numberOfSeats) seats and \(self.numberOfAxels) axels")
    }
    
    // Class methods can only be called by the class
    //  and not an instance of a class
    class func aboutVehicles() {
        println("Cars are awesome")
    }
}

var myCar = Vehicle()
myCar.wheels = 4
myCar.name = "Car"
myCar.color = "green"
myCar.numberOfSeats = 4
myCar.numberOfAxels = 4

myCar.inspectCar()

Vehicle.aboutVehicles()

// This call doesn't work
// myCar.aboutVehicles()
var x = "pants"
repeat(x,3)
