//
//  ViewController.swift
//  The Tweeting
//
//  Created by Adam Ostrich on 3/11/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tweetings: UITextView!
    @IBOutlet weak var category: UITextField!
    
    
    @IBAction func doTweeting(sender: AnyObject) {
        var tweetingP = PFObject(className: "Tweeting")
        // Adds id and date (timestamp) by default
        tweetingP["tweeting"] = self.tweetings.text
        tweetingP["user"]     = "Charlie"
        tweetingP["category"] = self.parseHashTags(self.tweetings.text)
        tweetingP.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if success {
                println("Tweeting saved successfully!")
                let cat: [String] = tweetingP["category"] as [String]
                println("Categories: \(cat)")
                self.tweetings.text = ""
            }
            else {
                println(error.description)
            }
        }
    }
    
    
    func parseHashTags(input: String) -> [String] {
        var arr: [String] = []
        let splitInput = split(input) { $0 == " " }
        for val in splitInput {
            if val[val.startIndex] == "#" {
                arr.append(val[val.startIndex..<val.endIndex])
            }
        }
        return arr
    }
    
    
    @IBAction func readTweetings(sender: AnyObject) {
        var tweetingQuery = PFQuery(className: "Tweeting")
        var cats = split(self.category.text) { $0 == " " }
        for i in 0..<cats.count {
            if cats[i][cats[i].startIndex] != "#" {
                cats[i] = "#" + cats[i]
            }
        }
        tweetingQuery.whereKey("category", containedIn: cats)
//        tweetingQuery.whereKey("category", containsAllObjectsInArray: cats)
        tweetingQuery.findObjectsInBackgroundWithBlock { (tweetingObjects: [AnyObject]!, error: NSError!) -> Void in
            for tweeting in tweetingObjects {
                if let text = tweeting["tweeting"] as? String {
                    println(text)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

