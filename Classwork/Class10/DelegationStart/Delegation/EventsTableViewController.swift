//
//  EventsTableViewController.swift
//  Delegation
//
//  Created by Thomas Degry on 28/01/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController, EventProtocol {
    
    @IBOutlet weak var editButton: UIBarButtonItem!

    // event array
    var arrEvents:[Event] = []
    
    func addEvent(newEvent: Event) {
        if newEvent.name != "" {
            arrEvents.append(newEvent)
        }
    }
    
    // ---------------------------------------------------
    // ==================
    // To to Add Event VC
    // ==================

    @IBAction func goToAddEventVC(sender: AnyObject) {
        // Initialize add VC
        let addEventVC = self.storyboard?.instantiateViewControllerWithIdentifier("addEventVC") as AddEventViewController
        addEventVC.delegate = self
        
        // Initialize navigation controller
        let navigationController = UINavigationController(rootViewController: addEventVC)
        
        // Present new controller, watch out this will be the navigation controller
        self.presentViewController(navigationController, animated:true, completion: nil)
    }
    
    // ---------------------------------------------------
    // =========================
    // Standard Table View Stuff
    // =========================

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvents.count
    }

    // Define how table cells are populated
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: "eventCell")
        
        let eventAtIndex: Event = self.arrEvents[indexPath.row]

        // Configure the cell
        cell.textLabel?.text = eventAtIndex.name
        cell.detailTextLabel?.text = eventAtIndex.location
    
        return cell
    }
    
    // ---------------------------------------------------
    // ==================
    // Table Cell Editing
    // ==================
    
    
    // Enable Row Editing
    @IBAction func editRows(sender: AnyObject) {
        // If editing
        if self.tableView.editing{
            self.tableView.setEditing(false, animated: false);
            self.editButton.style = UIBarButtonItemStyle.Plain;
            self.editButton.title = "Edit";
        }
            // If not editing
        else{
            self.tableView.setEditing(true, animated: true);
            self.editButton.title = "Done";
            self.editButton.style =  UIBarButtonItemStyle.Done;
        }
        
    }
    
    // Allow deleting with left swipe
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.arrEvents.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // -----------------------
    // When we're in edit mode
    // -----------------------
    
    // Say we can move all of the cells!
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // To make cell slide into destination
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Remove and get a copy of the cell contents
        let event = self.arrEvents.removeAtIndex(sourceIndexPath.row)
        
        // Add the contents to the new cell
        self.arrEvents.insert(event, atIndex: destinationIndexPath.row)
    }

    /*
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        <#code#>
    }
    */

}
