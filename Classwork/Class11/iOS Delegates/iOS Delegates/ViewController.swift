//
//  ViewController.swift
//  iOS Delegates
//
//  Created by Adam Ostrich on 2/2/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

// testing

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var campusesTable: UITableView!

    @IBOutlet weak var stuffTextField: UITextField!
    
    var gaCampuses = [["DC", "MD", "NY", "LA"], ["Paris", "Hong Kong"]]
//    var gaCampuses: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if gaCampuses.isEmpty {
            println("Your table view is empty")
            campusesTable.hidden = true
        }
        
        stuffTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UITableViewCell()

        sectionHeader.textLabel?.text = "Header!"
        sectionHeader.backgroundColor = UIColor.lightGrayColor()
        
        return sectionHeader
    }

    
    // ---------------------------------------------------
    // ================
    // Text Field Stuff
    // ================
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("Return key pressed!")
        textField.resignFirstResponder()
        
        return true
    }

    // ---------------------------------------------------
    // =========================
    // Standard Table View Stuff
    // =========================

    // Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return gaCampuses.count
    }
    
    // Number of Rows in Section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gaCampuses[section].count
    }
    
    // Define How to Populate Cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("campusCell", forIndexPath: indexPath) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "campusCell")

        // Here's the meat
        cell.textLabel?.text = gaCampuses[indexPath.section][indexPath.row]
        
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // ---------------------------------------------------


}

