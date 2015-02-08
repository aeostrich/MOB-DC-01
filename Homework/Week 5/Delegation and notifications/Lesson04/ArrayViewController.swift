//
//  ViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ArrayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var newStringTextLabel: UILabel!
    var inputTextField: UITextField!
    var tableViewCell: UITableViewCell!
    var tableView: UITableView!
    var arrayOfStrings: [String] = []
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.inputTextField.resignFirstResponder()
        self.arrayOfStrings.append(self.inputTextField.text)
        textField.text = ""
        self.tableView.reloadData()
        
        return true
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize newStringTextLabel
        self.newStringTextLabel = UILabel(frame: CGRect(x: 15, y: 115, width: 90, height: 21))
        self.newStringTextLabel.text = "New String:"
        self.view.addSubview(self.newStringTextLabel)
        
        // Initialize inputTextField
        self.inputTextField = UITextField(frame: CGRect(x: 15, y: 145, width: self.view.frame.width - 30, height: 40))
        self.inputTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.inputTextField.delegate = self
        self.view.addSubview(self.inputTextField)
        
        self.tableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "stringCell")
        
        // Initialize tableView
        self.tableView = UITableView(frame: CGRect(x: 15, y: 185, width: self.view.frame.width - 30, height: 395))
        self.tableView.addSubview(self.tableViewCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        

        
        /*
        TODO one: Add a table view AND a text input box to this view controller, either in code or via the storyboard. Accept keyboard input from the text view when the return key is pressed. Add the string that was entered into the text view into an array of strings (stored in this class).
        TODO two: Make this class a UITableViewDelegate and UITableViewDataSource that supply the above table view with cells. These cells should correspond to the text entered into the text box. E.g. If the text "one", then "two", then "three" was entered into the text box, there should be three cells in this table view that contain those strings in order.
        
        */
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
        return self.arrayOfStrings.count
    }
    
    // Define How to Populate Cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("stringCell") as? UITableViewCell ?? UITableViewCell(style: .Default, reuseIdentifier: "stringCell")
        
        // Here's the meat
        cell.textLabel?.text = self.arrayOfStrings[indexPath.row]
        
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // ---------------------------------------------------
}

