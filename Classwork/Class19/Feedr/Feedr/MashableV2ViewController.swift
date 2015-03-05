//
//  MashableV2ViewController.swift
//  Feedr
//
//  Created by Adam Ostrich on 3/4/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit
import SwiftyJSON

class MashableV2ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "http://mashable.com/stories.json") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                // Check for error
                if error != nil {
                    println(error.localizedDescription)
                }
                else {
                    let jsonDict = JSON(data)
                    self.json = jsonDict
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            })
            
            task.resume()
        }
        else {
            println("Oh noes!  Couldn't unwrap url.")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let jsonDict = self.json {
            return jsonDict["new"].count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        
        if let jsonDict = self.json {
            cell.textLabel?.text = jsonDict["new"][indexPath.row]["title"]
            cell.detailTextLabel?.text = jsonDict["new"][indexPath.row]["author"]
        }
        
        return cell
    }
    
    //on click
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("web", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let jsonDict = self.json {
            var destinationViewController = segue.destinationViewController as WebViewController
            var request: NSURLRequest?

            destinationViewController.request = NSURLRequest(URL: jsonDict["new"][index]["link"])
            destinationViewController.passedTitle = jsonDict["new"][index]["title"]
        }
        
    }
    
    
    
}
