//
//  ViewController.swift
//  Table View Demo
//
//  Created by Adam Ostrich on 2/2/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, Campus {

    var gaCampuses: [String] = []

    @IBOutlet weak var campusesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func goToAddCampusVC(sender: UIBarButtonItem) {
        let addVC = self.storyboard?.instantiateViewControllerWithIdentifier("addVC") as AddViewController
        addVC.delegate = self
        self.presentViewController(addVC, animated: true, completion: nil)
    }
    
    func addCampusToArray(campusName: String) {
        self.gaCampuses.append(campusName)
        println("New campus: \(campusName)")
        println(self.gaCampuses)
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
        return self.gaCampuses.count
    }
    
    // Define How to Populate Cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("campusCell", forIndexPath: indexPath) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "campusCell")
        
        // Here's the meat
        cell.textLabel?.text = self.gaCampuses[indexPath.row]
        
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // ---------------------------------------------------
}
