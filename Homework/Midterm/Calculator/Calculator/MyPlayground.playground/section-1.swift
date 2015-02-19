// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Calculator {
    // Higher number means higher priority
    let operatorPriority: [String: Int] = ["+":0, "-":0, "*":1, "/":1, "exp":2]
    
    // Tracks whether or not we are starting a new calculation
    var firstCalculation: Bool = true
    
    // Previous value in text field
    var previousValue: Double = 0
    // Current value in the text field
    var currentValue: Double = 0
    // Operation to perform with currentValue and previousValue
    var nextOperation: String = ""
    
    
    // Array used to keep track of calculations inside parentheses
    var parensCalculations: [Calculator] = []
    
    // Array used to keep track of calculations due to order of operations
    var orderOfOperations: [Calculator] = []
    
    
    
    // Reset calculator to initial values
    func reset() {
        self.firstCalculation = true
        self.previousValue = 0
        self.currentValue = 0
        self.nextOperation = ""
        self.parensCalculations.removeAll(keepCapacity: false)
    }
    
    
    // Grab the current copy of the calculator
    func currentCalculator() -> Calculator {
        var currentCalc: Calculator
        if self.parensCalculations.count > 0 {
            currentCalc = self.parensCalculations.last!
        }
        else {
            currentCalc = self
        }
        
        return currentCalc
    }
    
    // Grab the current Order of Operations copy of the calculator
    func currentOrderCalculator() -> Calculator {
        var currentCalc: Calculator
        if self.orderOfOperations.count > 0 {
            currentCalc = self.orderOfOperations.last!
        }
        else {
            currentCalc = self
        }
        
        return currentCalc
    }
    
    
    // Set current value
    func setCurrentValue(value: Double) {
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()
        currentOrderCalc.currentValue = value
    }
    
    // Retrieve Current Value
    func retrieveCurrentValue() -> Double {
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()
        return currentOrderCalc.currentValue
    }
    
    // Retrieve Previous Value
    func retrievePreviousValue() -> Double {
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()
        return currentOrderCalc.previousValue
    }
    
    
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
        // Grab the current copy of the calculator
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()

        // For the first calculation, just set the previous value to the number
        if currentCalc.firstCalculation {
            currentCalc.firstCalculation = false
            currentCalc.previousValue = currentCalc.currentValue
            currentCalc.nextOperation = operation
        }
        
        // If the operation is a higher priority than nextOperation, create a new calculator to start it
        else if self.operatorPriority[operation] > self.operatorPriority[currentOrderCalc.nextOperation] {
            currentCalc.orderOfOperations.append(Calculator())
            currentCalc.orderOfOperations.last?.previousValue = currentOrderCalc.currentValue
            currentCalc.orderOfOperations.last?.nextOperation = operation
        }
        // Otherwise, close out as many order of operations calculations as possible until
        //  the operator priorities are equal
        else {
            currentCalc.performOrderOfOperations(operation)
        }
        
        // We want to store the nextOperation and reset the currentValue every time
        
        currentCalc.currentValue = 0
    }
    
    // Perform the stored calculation
    func performStoredCalculation() -> Double {
        // Grab the current copy of the calculator
        var currentCalc = self.currentCalculator()
        
        switch currentCalc.nextOperation {
        case "+":
            println("Calculating: \(currentCalc.previousValue) + \(currentCalc.currentValue)")
            currentCalc.previousValue = currentCalc.previousValue + currentCalc.currentValue
        case "-":
            println("Calculating: \(currentCalc.previousValue) - \(currentCalc.currentValue)")
            currentCalc.previousValue = currentCalc.previousValue - currentCalc.currentValue
        case "*":
            println("Calculating: \(currentCalc.previousValue) * \(currentCalc.currentValue)")
            currentCalc.previousValue = currentCalc.previousValue * currentCalc.currentValue
        case "/":
            println("Calculating: \(currentCalc.previousValue) / \(currentCalc.currentValue)")
            currentCalc.previousValue = currentCalc.previousValue / currentCalc.currentValue
        case "exp":
            println("Calculating: \(currentCalc.previousValue) exp \(currentCalc.currentValue)")
            currentCalc.previousValue = pow(currentCalc.previousValue, currentCalc.currentValue)
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
        if self.parensCalculations.count > 0 {
            // Grab the final element of the array
            var currentCalc = self.parensCalculations.removeLast()
            
            // Grab the calculator one level up
            var superCalc = self.currentCalculator()
            
            // Set the current value of the superCalc to the final value of currentCalc
            superCalc.currentValue = currentCalc.performStoredCalculation()
        }
    }
    
    // Perform Order of Operations
    func performOrderOfOperations(operation: String) {
        var currentCalc = self.currentCalculator()
        var currentOrderCalc: Calculator
        var superOrderCalc: Calculator
        
        
        // Case 1: We just have the main instance and perform the calculation normally
        if currentCalc.orderOfOperations.count == 0 {
            currentCalc.performStoredCalculation()
            currentCalc.nextOperation = operation
        }

        // Case 2
        else {
            // Specify the current and super orderCalc's
            currentOrderCalc = currentCalc.currentOrderCalculator()
        
            // If there is only one order of operations instance, set the superOrderCalc to self
            if currentCalc.orderOfOperations.count == 1 {
                superOrderCalc = self
            }
            // Otherwise, look back one in the array and make that the super
            else {
                superOrderCalc = currentCalc.orderOfOperations[currentCalc.orderOfOperations.endIndex-2]
            }
            
            
            // Close out the calculation if the priority is right
            if self.operatorPriority[operation] <= self.operatorPriority[currentOrderCalc.nextOperation] {
                
                superOrderCalc.currentValue = currentOrderCalc.performStoredCalculation()
                currentCalc.orderOfOperations.removeLast()
                

                // Recursive call to self if there are more elements in the array
                currentCalc.performOrderOfOperations(operation)
            }
        }
        
        
    }

    // Finish Order of Operations Calculations
    func finishOrderOfOperations() {
        var currentCalc = self.currentCalculator()
        
        while currentCalc.orderOfOperations.count > 0 {
            // Grab the final element of the array
            var currentOrderCalc = currentCalc.orderOfOperations.removeLast()
            
            // Grab the calculator one level up
            var superOrderCalc = currentCalc.currentOrderCalculator()
            
            // Close out the calculation
            superOrderCalc.currentValue = currentOrderCalc.performStoredCalculation()
        }
    }

    
    // Finish all calculations
    func finishCalculation() -> Double {
        // Finish any calculations within parentheses
        while self.parensCalculations.count > 0 {
            self.finishOrderOfOperations()
            self.closeParens()
        }
        
        // Finish top level order of operations
        while self.orderOfOperations.count > 0 {
            self.finishOrderOfOperations()
        }
        
        // Perform the stored top level calculation
        return self.performStoredCalculation()
    }
}


var calc = Calculator()
/*
calc.setCurrentValue(5)
calc.performNewCalculation("+")
calc.retrievePreviousValue()
calc.setCurrentValue(3)
calc.performNewCalculation("-")
calc.retrievePreviousValue()

calc.openParens()
calc.retrievePreviousValue()
calc.retrieveCurrentValue()
calc.currentCalculator().nextOperation
calc.setCurrentValue(1)
calc.retrieveCurrentValue()
calc.performNewCalculation("*")
calc.currentCalculator().firstCalculation
calc.retrievePreviousValue()
calc.retrieveCurrentValue()
calc.currentCalculator().nextOperation

calc.openParens()
calc.setCurrentValue(1)
calc.performNewCalculation("+")
calc.setCurrentValue(1)

calc.finishCalculation()
calc.previousValue
*/

calc.setCurrentValue(5)
calc.performNewCalculation("+")
calc.setCurrentValue(7)
calc.currentCalculator().orderOfOperations.count
calc.performNewCalculation("*")
calc.retrievePreviousValue()
calc.currentCalculator().orderOfOperations.count
calc.retrievePreviousValue()
calc.retrieveCurrentValue()
calc.nextOperation
calc.currentCalculator().orderOfOperations.last?.nextOperation
calc.setCurrentValue(2)
calc.orderOfOperations.count
calc.performNewCalculation("exp")
calc.retrievePreviousValue()
calc.orderOfOperations[1]
calc.setCurrentValue(2)
calc.orderOfOperations.count
calc.retrievePreviousValue()

calc.performNewCalculation("-")
calc.retrievePreviousValue()
calc.orderOfOperations.count
calc.setCurrentValue(20)
calc.performNewCalculation("/")
calc.setCurrentValue(4)
calc.performNewCalculation("-")
calc.setCurrentValue(7)

calc.finishCalculation()