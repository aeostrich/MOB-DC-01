//
//  ViewController.swift
//  Table View Demo
//
//  Created by Adam Ostrich on 1/28/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

protocol Campus {
    func addCampusToArray(campusName: String)
}


class AddViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: Campus?
    
    @IBOutlet weak var inTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet weak var intenseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inTextField.delegate = self
        self.errorMessage.hidden = true
        self.hiddenLabel.hidden = true
        self.intenseLabel.hidden = true
        
        // Listen for notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "unhideCurrentLabels:", name: "unhideHiddenLabels", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textHasChanged:", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    // Do stuff when the text has changed
    func textHasChanged(notification:NSNotification) {
        var strlen = countElements(self.inTextField.text)
        if strlen == 0 {
            self.intenseLabel.hidden = true
        }
        else {
            self.intenseLabel.hidden = false
            var newText = self.inTextField.text
            self.intenseLabel.text = String(newText[advance(newText.startIndex, strlen-1)])
        }
        
        self.view.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
    
    // Send notification
    @IBAction func pressPostButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("unhideHiddenLabels", object: nil)
        // Can pass data with object
    }

    // Respond when notification is received
    func unhideCurrentLabels(notification: NSNotification) {
        self.hiddenLabel.hidden = false
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.inTextField.text.isEmpty {
            inTextField.resignFirstResponder()
            self.errorMessage.hidden = false
        }
        else {
            self.errorMessage.hidden = true
        }
        
        return true
    }
    
    
    @IBAction func addAndGoBack(sender: AnyObject) {
        if self.inTextField.text.isEmpty {
            self.errorMessage.text = "You can't have an empty campus"
            self.errorMessage.hidden = false
        }
        else {
            self.errorMessage.hidden = true
            self.delegate?.addCampusToArray(inTextField.text)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}

