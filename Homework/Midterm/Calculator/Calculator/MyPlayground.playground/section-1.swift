// Playground - noun: a place where people can play

import UIKit
import Darwin

var str = "Hello, playground"

func factorial(number: Int, prev: Int=1) -> Int {
    if number == 0 {
        return 1
    }
    else if number == 1 {
        return prev
    }
    else {
        return factorial(number-1, prev: number * prev)
    }
}


class Calculator {
    
    // ------------
    // Declarations
    // ------------
    
    // Higher number means higher priority
    let operatorPriority: [String: Int] = ["+":0, "-":0, "*":1, "/":1, "x^y":2]

    
    // Previous value in text field
    var previousValue: Double = 0
    // Current value in the text field
    var currentValue: Double = 0
    // Operation to perform with currentValue and previousValue
    var nextOperation: String = ""
    
    
    // Tracks whether or not we are starting a new calculation
    var firstCalculation: Bool = true
    
    // Tracks whether unary operations should be performed on currentValue or previousValue
    var unaryPreviousValue: Bool = false
    
    // Allow Exponential notation
    var exponential: Bool = false
    var exponentialValue: Int = 0
    
    // Tracks whether trig calculations treat values as decimal or radians
    var radians: Bool = false
    
    // Tracks whether the numbers added are before or after the decimal
    var fractions: Bool = false
    var fractionLevel: Double = 0.1
    
    // Handle memory operations
    var memoryValue: Double = 0
    

    
    // Array used to keep track of calculations inside parentheses
    var parensCalculations: [Calculator] = []
    
    // Array used to keep track of calculations due to order of operations
    var orderOfOperations: [Calculator] = []
    
    
    // ----------------------------------------------------------------------
    
    
    // -----------------------------
    // Retrieve Copies of Calculator
    // -----------------------------
    
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
    
    // Grab the current Order of Operations copy of the calculator for the current copy of the calculator
    func retrieveLowestLevelCalc() -> Calculator {
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()

        return currentOrderCalc
    }
    
    // ----------------------------------------------------------------------
    
    // ----------------------------------------
    // Set and Retrieve Current/Previous Values
    // ----------------------------------------
    
    // Set current value
    func setCurrentValue(value: Double) {
        self.retrieveLowestLevelCalc().currentValue = value
    }
    
    // Retrieve Current Value
    func retrieveCurrentValue() -> Double {
        return self.retrieveLowestLevelCalc().currentValue
    }
    
    // Retrieve Previous Value
    func retrievePreviousValue() -> Double {
        return self.retrieveLowestLevelCalc().previousValue
    }
    
    // Clear current display
    func clearCurrentDisplay() {
        self.retrieveLowestLevelCalc().currentValue = 0
    }
    
    // ----------------------------------------------------------------------
    
    // ------------
    // Push Buttons
    // -------------
    
    // Press decimal point
    func pressDecimalPoint() {
        // Ignore if currently creating an exponential number
        if !self.exponential {
            self.retrieveLowestLevelCalc().fractions = true
        }
    }
    
    // Press radians
    func pressRad() {
        self.radians = !self.radians
    }
    
    // Press EE (exponential)
    func pressEE() {
        // Only apply it if it's not already there
        if !self.exponential {
            self.exponential = true
            self.exponentialValue = 0
        }
    }
    
    // Press Number
    func pressNumber(number: Int) {
        // Grab the lowest level calculator
        var calc = self.retrieveLowestLevelCalc()

        // If we're using exponential notation, only add normally to exponentialValue
        if self.exponential {
            self.exponentialValue = self.exponentialValue * 10 + number
        }
        
        // Otherwise, treat numbers normally
        else {
            // Check to see if we're adding fractions
            if (calc.fractions) {
                calc.currentValue += Double(number) * calc.fractionLevel
                // Setup for the next fraction level
                calc.fractionLevel *= 0.1
            }
                // Otherwise, add the numbers normally
            else {
                calc.currentValue = calc.currentValue * 10.0 + Double(number)
            }
        }
    }
    
    // ----------------------------------------------------------------------
    
    // --------------------
    // Perform Calculations
    // --------------------
    
    // Perform a unary operation
    func performUnaryOperation(operation: String) {
        // Grab the lowest level calculator
        var calc = self.retrieveLowestLevelCalc()
        
        // Resolve the exponential notation if necessary
        self.resolveExponentialNotation()
        
        // Retrieve the previousValue or currentValue based on unaryPreviousValue
        var value = calc.unaryPreviousValue ? calc.previousValue : calc.currentValue
        
        switch operation {
        case "+/-":
            value = -value
        case "%":
            value = value / 100
        case "x^2":
            value = pow(value, 2)
        case "x^3":
            value = pow(value, 3)
        case "e^x":
            value = pow(M_E, value)
        case "10^x":
            value = pow(10, value)
        case "1/x":
            if value == 0 { self.errorOut() }
            else { value = 1.0 / value }
        case "sqrt":
            // If value is less than 0, error out
            // Don't want to deal with complex numbers
            if value < 0 { self.errorOut() }
            else { value = sqrt(value) }
        case "cubert":
            value = pow(value, 1.0/3.0)
        case "ln":
            // Error if equal to or less than 0
            if value <= 0 { self.errorOut() }
            else { value = log(value) }
        case "log10":
            // Error if equal to or less than 0
            if value <= 0 { self.errorOut() }
            else { value = log10(value) }
        case "x!":
            // Error if less than 0
            if value < 0 { self.errorOut }
            // Force to integer, don't want to deal with factorials of fractions...
            else { value = Double(factorial(Int(value))) }
        case "sin":
            value = self.radians ? sin(value) : sin(value * M_PI / 180)
        case "cos":
            value = self.radians ? cos(value) : cos(value * M_PI / 180)
        case "tan":
            let cosValue = self.radians ? cos(value) : cos(value * M_PI / 180)
            
            // Error out if it's equal to 0
            if cosValue == 0 { self.errorOut() }
            else { value = self.radians ? tan(value) : tan(value * M_PI / 180) }
        case "e":
            value = M_E
        case "sinh":
            value = self.radians ? sinh(value) : sinh(value * M_PI / 180)
        case "cosh":
            value = self.radians ? cosh(value) : cosh(value * M_PI / 180)
        case "tanh":
            let coshValue = self.radians ? cosh(value) : cosh(value * M_PI / 180)
            
            // Error out if it's equal to 0
            if coshValue == 0 { self.errorOut() }
            else { value = self.radians ? tanh(value) : tanh(value * M_PI / 180) }
        case "π":
            value = M_PI
        case "rand":
            value = Double(arc4random()) / Double(UINT_MAX)
        
        // Secondary Functions
        case "sin^-1":
            // Error out if the value is outside of the range (-1,1)
            if abs(value) > 1 { self.errorOut() }
            else { value = self.radians ? asin(value) : asin(value * M_PI / 180) }
        case "cos^-1":
            // Error out if the value is outside of the range (-1,1)
            if abs(value) > 1 { self.errorOut() }
            else { value = self.radians ? acos(value) : acos(value * M_PI / 180) }
        case "tan^-1":
            value = self.radians ? atan(value) : atan(value * M_PI / 180)
        case "sinh^-1":
            value = self.radians ? asinh(value) : asinh(value * M_PI / 180)
        case "cosh^-1":
            // Error out if the value is less than 1
            if value < 1 { self.errorOut() }
            else { value = self.radians ? acosh(value) : acosh(value * M_PI / 180) }
        case "tanh^-1":
            // Error out if the vaue is outside of the non-inclusive range (-1,1)
            if abs(value) >= 1 { self.errorOut() }
            else { value = self.radians ? atanh(value) : atanh(value * M_PI / 180) }
        case "2^x":
            value = pow(2.0, value)
        case "log2":
            // Error if equal to or less than 0
            if value <= 0 { self.errorOut() }
            else { value = log2(value) }
            
        default:
            println("\(operation) is not a valid unary operation")
        }
        
        // Put the value back into the calculator
        if calc.unaryPreviousValue {
            calc.previousValue = value
        }
        else {
            calc.currentValue = value
        }
    }
    
    // Perform normal calculations
    func performNewCalculation(operation: String) {
        // Grab the current copy of the calculator
        var currentCalc = self.currentCalculator()
        var currentOrderCalc = currentCalc.currentOrderCalculator()

        self.resolveExponentialNotation()

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
        
        // Mark that any future unary operations should be performed on currentValue
        currentCalc.unaryPreviousValue = false

        // We want to store the nextOperation and reset the currentValue every time
        currentCalc.currentValue = 0
        currentCalc.fractions = false
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
            // Handle divide by zero
            if currentCalc.currentValue == 0 {
                self.errorOut()
                return 0
            }
            currentCalc.previousValue = currentCalc.previousValue / currentCalc.currentValue
        case "x^y":
            println("Calculating: \(currentCalc.previousValue) exp \(currentCalc.currentValue)")
            currentCalc.previousValue = pow(currentCalc.previousValue, currentCalc.currentValue)
            // Should never get here
        case "x_root_of_y":
            if currentCalc.currentValue == 0 {
                self.errorOut()
                return 0
            }
            currentCalc.previousValue = pow(currentCalc.previousValue, 1.0 / currentCalc.currentValue)

        // Secondary Operations
        case "y^x":
            currentCalc.previousValue = pow(currentCalc.currentValue, currentCalc.previousValue)
        case "logy":
            // Error if equal to or less than 0
            if (currentCalc.previousValue <= 0) || (currentCalc.currentValue <= 0) {
                self.errorOut()
                return 0
            }
            
            // Otherwise, perform the calculation
            currentCalc.previousValue = log(currentCalc.previousValue) / log(currentCalc.currentValue)

        default:
            println("\(currentCalc.nextOperation) is not a valid operation")
        }
        
        return currentCalc.previousValue
    }
    
    // ----------------------------------------------------------------------
    
    // -----------
    // Parentheses
    // -----------
    
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
    
    // ----------------------------------------------------------------------
    
    // -------------------
    // Order of Operations
    // -------------------
    
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
        
        // Resolve exponential notation
        
        while currentCalc.orderOfOperations.count > 0 {
            // Grab the final element of the array
            var currentOrderCalc = currentCalc.orderOfOperations.removeLast()
            
            // Grab the calculator one level up
            var superOrderCalc = currentCalc.currentOrderCalculator()
            
            // Close out the calculation
            superOrderCalc.currentValue = currentOrderCalc.performStoredCalculation()
        }
    }
    
    // ----------------------------------------------------------------------

    // --------------
    // Finish & Reset
    // --------------
    
    // Finish all calculations
    func finishCalculation() -> Double {
        // Resolve exponential notation
        self.resolveExponentialNotation()
        
        // If there is only a currentValue and no next operation,
        //  set the previousValue to it
        self.resolveLonelyValue()
        
        // Finish any calculations within parentheses
        while self.parensCalculations.count > 0 {
            self.finishOrderOfOperations()
            self.closeParens()
        }
        
        // Finish top level order of operations
        while self.orderOfOperations.count > 0 {
            self.finishOrderOfOperations()
        }
        
        // Mark that any future unary operations should be performed on previousValue
        self.unaryPreviousValue = true
        
        // Perform the stored top level calculation
        return self.performStoredCalculation()
    }
    
    // Reset calculator to initial values
    func reset() {
        self.firstCalculation = true
        self.fractions = false
        self.exponential = false
        self.previousValue = 0
        self.currentValue = 0
        self.nextOperation = ""
        self.parensCalculations.removeAll(keepCapacity: false)
    }
    
    // If there is only a currentValue, set previousValue to it
    func resolveLonelyValue() {
        // Grab lowest level calculator
        var calc = self.retrieveLowestLevelCalc()
        
        // If there's no next Operation, just set previousValue to currentValue
        if calc.nextOperation == "" {
            calc.previousValue = calc.currentValue
        }
    }
    
    // Resolve EE
    func resolveExponentialNotation() {
        var calc = self.retrieveLowestLevelCalc()
        
        // Resolve exponential notation
        if self.exponential {
            // Calculate the current value from the exponential notation
            calc.setCurrentValue(calc.currentValue * pow(10.0, Double(self.exponentialValue)))
            
            self.exponential = false
            self.exponentialValue = 0
        }
    }

    
    // ----------------------------------------------------------------------
    
    // -----------------
    // Memory Operations
    // -----------------
    
    // Note: Memory operations only ever operate on the top level calculator
    
    // Memory Clear
    func memoryClear() {
        self.memoryValue = 0
    }
    
    // Memory Add
    func memoryAdd() {
        self.memoryValue += self.finishCalculation()
    }
    
    // Memory Subtract
    func memorySubtract() {
        self.memoryValue -= self.finishCalculation()
    }
    
    // Memory Recall
    func memoryRecall() {
        self.setCurrentValue(self.memoryValue)
    }

    
    // ----------------------------------------------------------------------
    
    // -----------
    // Post Errors
    // -----------
    
    // TODO: Add handling of calculationError notification
    //       Disable all buttons until everything is cleared
   
    func errorOut() {
        NSNotificationCenter.defaultCenter().postNotificationName("calculationError", object: nil)
    }
    
    // ----------------------------------------------------------------------

    // ----------------------
    // Print the currentValue
    // ----------------------
    
    func printCurrentValue() -> String {
        let curr = self.retrieveCurrentValue()
        
        // If using exponential notation, print it out with it
        if self.exponential {
            return "\(curr) E \(self.exponentialValue)"
        }
        
        // Otherwise, just print the value
        else {
            return "\(curr)"        }
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
/*
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
calc.performNewCalculation("x^y")
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
*/
/*
calc.pressNumber(4)
calc.retrieveCurrentValue()

calc.pressNumber(5)
calc.retrieveCurrentValue()

calc.pressNumber(0)
calc.retrieveCurrentValue()

calc.pressDecimalPoint()
calc.pressNumber(7)
calc.retrieveCurrentValue()
calc.pressNumber(2)
calc.retrieveCurrentValue()

calc.performNewCalculation("/")

calc.orderOfOperations.count


calc.pressNumber(2)
calc.retrieveCurrentValue()
calc.pressNumber(5)
calc.retrieveCurrentValue()

calc.finishCalculation()
*/
/*
calc.pressNumber(1)
calc.performNewCalculation("+")
calc.pressNumber(4)
calc.memoryValue

calc.memoryAdd()
calc.memoryValue

calc.memorySubtract()
calc.memoryValue

calc.retrieveCurrentValue()
calc.memoryRecall()
calc.retrieveCurrentValue()

calc.memoryClear()
calc.memoryValue

calc.performUnaryOperation("e")
calc.retrieveCurrentValue()
*/

calc.pressNumber(3)
calc.printCurrentValue()

calc.performUnaryOperation("+/-")
calc.printCurrentValue()


func pants(this: Int, that: Int) {
    println("\(this) and \(that)")
}


var x: Double = 0.0699268119435104

x % 1 > 0.0