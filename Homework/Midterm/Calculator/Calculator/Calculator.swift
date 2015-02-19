//
//  Calculator.swift
//  Calculator
//
//  Created by Adam Ostrich on 2/18/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

class Calculator {
    // Tracks whether or not we are starting a new calculation
    var firstCalculation: Bool = true
    
    // Previous value in text field
    var previousValue: Double = 0
    // Current value in the text field
    var currentValue: Double = 0
    // Operation to perform with currentValue and previousValue
    var nextOperation: String = ""
    
    
    // Array used to keep track of calculations inside parentheses
    var parensCalculations: [Calculator] = [Calculator()]
    
    
    // Perform a unary operation
    func performUnaryOperation(operation: String) {
        switch operation {
            case "+/-":
                self.currentValue = -self.currentValue
            case "%":
                self.currentValue = self.currentValue / 100
            default:
                println("\(operation) is not a valid unary operation")
        }
    }
    
    func performNewCalculation(operation: String) {
        // For the first calculation, just set the previous value to the number
        if firstCalculation {
            self.firstCalculation = false
            self.previousValue = self.currentValue
        }
        // Otherwise, perform the stored calculation
        else {
            self.performStoredCalculation()
        }
        
        // We want to store the nextOperation and reset the currentValue every time
        self.nextOperation = operation
        self.currentValue = 0
    }
    
    // Perform the stored calculation
    func performStoredCalculation() -> Double {
        // Grab the current copy of the calculator
        var currentCalc = self.parensCalculations.last!
        
        switch currentCalc.nextOperation {
        case "+":
            currentCalc.previousValue = currentCalc.previousValue + currentCalc.currentValue
        case "-":
            currentCalc.previousValue = currentCalc.previousValue - currentCalc.currentValue
        case "*":
            currentCalc.previousValue = currentCalc.previousValue * currentCalc.currentValue
        case "/":
            currentCalc.previousValue = currentCalc.previousValue / currentCalc.currentValue
        case "%":
            currentCalc.previousValue = currentCalc.previousValue % currentCalc.currentValue
            // Should never get here
        default:
            println("\(currentCalc.nextOperation) is not a valid operation")
        }
        
        return currentCalc.previousValue
    }
    
    // Open parentheses
    // Ignores any numbers already in currentValue
    func openParens() {
        // Start up a new calculator
        self.parensCalculations.append(Calculator())
    }
    
    // Close parentheses
    // Close out the final calculator
    func closeParens() {
        // Can only close parens if we opened them already
        if self.parensCalculations.count > 1 {
            // Grab the final element of the array
            var currentCalc = self.parensCalculations.removeLast()
            
            // Grab the calculator one level up
            var superCalc = self.parensCalculations.last!
            
            // Set the current value of the superCalc to the final value of currentCalc
            superCalc.currentValue = currentCalc.performStoredCalculation()
        }
    }
    
    // Finish all calculations
    func finishCalculation() {
        while self.parensCalculations.count > 1 {
            self.closeParens()
        }
    }
}