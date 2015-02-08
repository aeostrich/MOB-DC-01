import UIKit

class ViewController: UIViewController {

    // Functions of use for this exercise:
    // Translating a string to an integer: "1".toInt()
    // Getting the text from a text field: let text = textFieldName.text
    // Setting the text on a text label or text field: textLabelName.text = "some text"
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var totalTextField: UILabel!

    /*
    TODO: Create a text field, a label and a button in the storyboard's View Controller. Drag a new outlet from the label and text field to this file, then drag the 'touch up inside' event on the button into this file. When the button is clicked, make the text of the label display 'hello {whatever the text in the text field is}. Call an instructor/TA when you're done with this task.
    */
    
    @IBAction func nameButton(sender: AnyObject) {
        nameLabel.text = "Hello \(nameTextField.text)."
    }
    
    /*
    TODO: Paste the fibonacci number function that you previously created into this class. Change the text box to use a numeric keypad for input. When the button is pressed, make the label print out the nth number in the fibonacci sequence (where n is the value of the text in the text field). Call an instructor/TA when you're done with this task.
    */
    func nextFib(val1: Int, val2: Int, place: Int) -> Int {
        let newVal = val1 + val2
        
        if place == 1 {
            return newVal
        }
        
        return nextFib(val2, val2: newVal, place: place-1)
    }
    
    func findFibonacci(place: Int) -> Int {
        // Check to make sure the input makes sense
        if place < 1 {
            println("You fail")
            return Int(rand())
        }
            // Already know the values for places 1 and 2
        else if place == 1 {
            return 0
        }
        else if place == 2 {
            return 1
        }
        
        return nextFib(0, val2: 1, place: place-2)
    }
    
    @IBAction func calcFibonacci(sender: AnyObject) {
        if let val = nameTextField.text.toInt() {
            nameLabel.text = "Fibonacci number \(val) is \(findFibonacci(val))"
        }
        else {
            nameLabel.text = "What were you thinking?"
        }
    }
    
    
    /*
    TODO: Drag a new text field into the view controller, and create an outlet for it here. Make both text fields use the numeric keypad. One text field represents an optional tip percentage (in integer form, e.g 20 = 20% tip), the other represents the total amount of a bill. When the button is pressed, make the label display both the total amount and tip amount (e.g. "total: $100, tip: $15"). Call an instructor/TA when you're done with this task.
    */
    func tipCalculate(#bill: Float, tip: Float?) -> (total: Float, tip: Float) {
        var tipAmount: Float = 0
        if let percent = tip {
//            println(percent)
            tipAmount = (percent / 100.0) * bill
//            println(tipAmount)
        }
        
        return (bill + tipAmount, tipAmount)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        if let bill = billTextField.text.toInt() {
            if let tip = tipTextField.text.toInt() {
                let result = tipCalculate(bill: Float(bill), tip: Float(tip))
                
                totalTextField.text = "Bill: \(result.total), Tip: \(result.tip)"
            }
            else {
                totalTextField.text = "nope"
            }
        }
        else {
            totalTextField.text = "not even close"
            }
    }

}

