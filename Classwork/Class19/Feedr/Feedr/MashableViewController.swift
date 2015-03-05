//
//  MashableViewController.swift
//  Feedr
//
//  Created by Adam Ostrich on 3/4/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit

class MashableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var json: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "http://mashable.com/stories.json") {
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
            if let newArticles = jsonData["new"] as? NSArray {
                return newArticles.count
            }
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        
        if let jsonData = self.json {
            if let newArticles = jsonData["new"] as? NSArray {
                if let article = newArticles[indexPath.row] as? NSDictionary {
                    if let title = article["title"] as? NSString {
                        cell.textLabel?.text = title
                    }
                    if let author = article["author"] as? NSString {
                        cell.detailTextLabel?.text = author
                    }
                }
            }
        }
        
        return cell
    }
    
    //on click
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        var url: NSURL?

        if let jsonData = self.json {
            if let newArticles = jsonData["new"] as? NSArray {
                if let article = newArticles[indexPath.row] as? NSDictionary {
                    if let link = article["link"] as? NSString {
                        url = NSURL(string: link)
                    }
                }
            }
        }
        
        performSegueWithIdentifier("web", sender: NSURLRequest(URL: url!))
        */
        performSegueWithIdentifier("web", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let index = sender as? Int {
            if let jsonData = self.json {
                if let newArticles = jsonData["new"] as? NSArray {
                    if let article = newArticles[index] as? NSDictionary {
                        var destinationViewController = segue.destinationViewController as WebViewController
                        var request: NSURLRequest?
                        
                        if let link = article["link"] as? NSString {
                            if let url = NSURL(string: link) {
                                destinationViewController.request = NSURLRequest(URL: url)
                            }
                        }
                        
                        if let myTitle = article["title"] as? NSString {
                            destinationViewController.passedTitle = myTitle
                        }
                    }
                }
            }
        }
        /*
        if let request = sender as? NSURLRequest {
            var destinationViewController = segue.destinationViewController as WebViewController
            destinationViewController.request = request
            destinationViewController.passedTitle =
        }
        */
    }
    
    

}
