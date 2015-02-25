//
//  ViewController.swift
//  Athlete Name Persistence
//
//  Created by Adam Ostrich on 2/23/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var names: [[String: String]] = []
    var coaches: [NSDictionary] = []

    @IBAction func addNameButton(sender: AnyObject) {
        self.names.append(["first": self.firstTextField.text, "last": self.lastTextField.text])
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.names, forKey: "names")
        
        self.tableView.reloadData()
        
        println(names)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load array from user defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        let nameCheck: AnyObject? = defaults.objectForKey("names")
        
        if nameCheck != nil {
            self.names = nameCheck as [[String: String]]
        }
        
        // Load coach names
        var coachNamesPath = NSBundle.mainBundle().pathForResource("Coaches", ofType: "plist")
        // To read from data, use NSArray object
        var coachNamesData = NSArray(contentsOfFile: coachNamesPath!)
        
        println(coachNamesData)

        for thing in coachNamesData! {
            self.coaches.append(thing as NSDictionary)
        }

        
        println(self.coaches)
        println(self.names)
    }
    
    // ---------------------------------------------------
    // =========================
    // Standard Table View Stuff
    // =========================
    
    // Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Number of Rows in Section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    // Define How to Populate Cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "nameCell")
        
        // This instance
        let thisName = self.names[indexPath.row]
        
        // Here's the meat
        cell.textLabel?.text = thisName["first"]
        cell.detailTextLabel?.text = thisName["last"]
        
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // ---------------------------------------------------

}

