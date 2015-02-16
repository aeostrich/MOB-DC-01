//
//  NewGameViewController.swift
//  Hangman
//
//  Created by Adam Ostrich on 2/16/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {
    
    var inputPhraseTextField: UITextField!
    var cancelButton: UIButton!
    var setPhraseButton: UIButton!
    
    var warningLabel: UILabel!
    
    var delegate: HangmanDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.initializeUI()
    }
    
    func setPhrase() {
        self.delegate?.setPhrase(self.inputPhraseTextField.text)
        self.dismiss()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Restrict the contents of inputPhraseTextField to 35 characters
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        
        if newLength > 35 {
            if self.warningLabel == nil {
                self.addWarningLabel()
            }
        }
        
        return newLength <= 35 //Bool
        
    }
    
    func addWarningLabel() {
        self.warningLabel = UILabel(frame: CGRect(x: 50, y: 210, width: self.view.frame.width-100, height: 60))
        self.warningLabel.text = "Phrase must be less than 35 characters!"
        self.warningLabel.textAlignment = NSTextAlignment.Center
        self.warningLabel.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.warningLabel.numberOfLines = 0
        self.warningLabel.lineBreakMode = .ByWordWrapping
        self.warningLabel.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(self.warningLabel)
    }
    
    func initializeUI() {
        // Input Phrase Text Field
        self.inputPhraseTextField = UITextField(frame: CGRect(x: 16, y: 100, width: self.view.frame.width-64, height: 40))
        self.inputPhraseTextField.placeholder = "Phrase..."
        self.inputPhraseTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.inputPhraseTextField.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleBottomMargin
        self.inputPhraseTextField.delegate = self
        self.view.addSubview(self.inputPhraseTextField)
        
        // Cancel Button
        self.cancelButton = UIButton(frame: CGRect(x: 16, y: 160, width: self.view.frame.width/2-32, height: 40))
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
        self.setPhraseButton = UIButton(frame: CGRect(x: self.view.frame.width/2+16, y: 160, width: self.view.frame.width/2-32, height: 40))
        self.setPhraseButton.setTitle("Set Phrase", forState: .Normal)
        self.setPhraseButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.setPhraseButton.backgroundColor = MyColors.green()
        self.setPhraseButton.layer.cornerRadius = 10
        self.setPhraseButton.addTarget(self, action: "setPhrase", forControlEvents: .TouchUpInside)
        self.setPhraseButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.setPhraseButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.setPhraseButton.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(self.setPhraseButton)
    }
}
