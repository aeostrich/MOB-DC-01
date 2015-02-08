//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var keyTextField: UITextField!
    var valueTextField: UITextField!
    var tableViewCell: UITableViewCell!
    var tableView: UITableView!
    
    var dictionary: [String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize keyTextField
        self.keyTextField = UITextField(frame: CGRect(x: 16, y: 72, width: self.view.frame.width/2 - 32, height: 30))
        self.keyTextField.placeholder = "Key"
        self.keyTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.keyTextField)
        
        // Initialize valueTextField
        self.valueTextField = UITextField(frame: CGRect(x: self.view.frame.width/2 + 16, y: 72, width: self.view.frame.width/2 - 32, height: 30))
        self.valueTextField.placeholder = "Value"
        self.valueTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.valueTextField.delegate = self
        self.view.addSubview(self.valueTextField)
        
        // Initialize tableViewCell
        self.tableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "dictionaryCell")
        
        // Initialize tableView
        self.tableView = UITableView(frame: CGRect(x: 16, y: 100, width: self.view.frame.width-32, height: 500))
        self.tableView.addSubview(self.tableViewCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        
        // Setup observer to see when the keyboard is up/down
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showingKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hidingKeyboard:", name: UIKeyboardWillHideNotification, object: nil)

        
        /*
        TODO three: Add TWO text views and a table view to this view controller, either using code or storyboard. Accept keyboard input from the two text views. When the 'return' button is pressed on the SECOND text view, add the text view data to a dictionary. The KEY in the dictionary should be the string in the first text view, the VALUE should be the second.
        TODO four: Make this class a UITableViewDelegate and UITableViewDataSource that supply this table view with cells that correspond to the values in the dictionary. Each cell should print out a unique pair of key/value that the map contains. When a new key/value is inserted, the table view should display it.
        TODO five: Make the background of the text boxes in this controller BLUE when the keyboard comes up, and RED when it goes down. Start with UIKeyboardWillShowNotification and NSNotificationCenter.
        */
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.valueTextField.resignFirstResponder()
        self.dictionary[self.keyTextField.text] = self.valueTextField.text
        self.keyTextField.text = ""
        self.valueTextField.text = ""
        self.tableView.reloadData()
        
        return true
    }
    
    func showingKeyboard(notification: NSNotification) {
        self.keyTextField.backgroundColor = UIColor.blueColor()
        self.valueTextField.backgroundColor = UIColor.blueColor()
    }
    
    func hidingKeyboard(notification: NSNotification) {
        self.keyTextField.backgroundColor = UIColor.redColor()
        self.valueTextField.backgroundColor = UIColor.redColor()
    }
    
    // ---------------------------------------------------
    // =========================
    // Standard Table View Stuff
    // =========================
    
    // Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of Rows in Section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictionary.count
    }
    
    // Define How to Populate Cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dictionaryCell") as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "dictionaryCell")
        
        var dictMap: [(String, String)]
        
        // Map the dictionary to an array
        if (dictionary.count > 0) {
            dictMap = map(self.dictionary) {
                (key, value) in
                (key, value)
            }
            
            cell.textLabel?.text = dictMap[indexPath.row].0
            cell.detailTextLabel?.text = dictMap[indexPath.row].1
        }
        
        
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // ---------------------------------------------------

}
