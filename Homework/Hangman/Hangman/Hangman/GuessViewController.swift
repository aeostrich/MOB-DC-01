//
//  GuessViewController.swift
//  Hangman
//
//  Created by Adam Ostrich on 2/16/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController, UITextFieldDelegate {

    var inputGuessTextField: UITextField!
    var cancelButton: UIButton!
    var makeGuessButton: UIButton!
    
    var delegate: HangmanDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.initializeUI()
        
    }
    
    func makeGuess() {
        self.delegate?.evaluateGuess(self.inputGuessTextField.text)
        self.dismiss()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Restrict the number of input characters for the inputGuessTextField to 1
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        return newLength <= 1 //Bool
        
    }
    
    func initializeUI() {
        // Input Phrase Text Field
        self.inputGuessTextField = UITextField(frame: CGRect(x: self.view.frame.width*2/5, y: 100, width: self.view.frame.width/5, height: 80))
        self.inputGuessTextField.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.inputGuessTextField.textAlignment = NSTextAlignment.Center
        self.inputGuessTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.inputGuessTextField.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleBottomMargin
        self.inputGuessTextField.delegate = self
        self.view.addSubview(self.inputGuessTextField)
        
        // Cancel Button
        self.cancelButton = UIButton(frame: CGRect(x: 16, y: 200, width: self.view.frame.width/2-32, height: 40))
        self.cancelButton.setTitle("Cancel", forState: .Normal)
        self.cancelButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.cancelButton.backgroundColor = MyColors.red()
        self.cancelButton.layer.cornerRadius = 10
        self.cancelButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        self.cancelButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.cancelButton.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(self.cancelButton)
        
        // Set Phrase Button
        self.makeGuessButton = UIButton(frame: CGRect(x: self.view.frame.width/2+16, y: 200, width: self.view.frame.width/2-32, height: 40))
        self.makeGuessButton.setTitle("Make Guess", forState: .Normal)
        self.makeGuessButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.makeGuessButton.backgroundColor = MyColors.green()
        self.makeGuessButton.layer.cornerRadius = 10
        self.makeGuessButton.addTarget(self, action: "makeGuess", forControlEvents: .TouchUpInside)
        self.makeGuessButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.makeGuessButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.makeGuessButton.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(self.makeGuessButton)
    }
}
