//
//  ViewController.swift
//  Feedr
//
//  Created by Tedi Konda on 3/2/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var tempData = ["Ena's tail is apperantly OK", "MOB Class is awesome", "Pigs sighted flying"]
    var json: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "http://www.reddit.com/.json") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                // Check for error
                if error != nil {
                    println(error.localizedDescription)
                }
                else {
                    if let jsonDict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) {
                        self.json = jsonDict as? NSDictionary
                    }
                    else {
                        println("Error parsing JSON data")
                    }
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
        if let jsonData = self.json {
            if let data = jsonData["data"] as? NSDictionary {
                if let children = data["children"] as? NSArray {
                    return children.count
                }
            }
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        if let jsonData = self.json {
            if let data = jsonData["data"] as? NSDictionary {
                if let children = data["children"] as? NSArray {
                    if let articleDict = children[indexPath.row] as? NSDictionary {
                        if let articleData = articleDict["data"] as? NSDictionary {
                            if let title = articleData["title"] as? NSString {
                                cell.textLabel?.text = title
                            }
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    //on click
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var url = NSURL(string: "http://tedi.io")
        performSegueWithIdentifier("web", sender: NSURLRequest(URL: url!))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let request = sender as? NSURLRequest {
            var destinationViewController = segue.destinationViewController as WebViewController
            destinationViewController.request = request
        }
    }


}

