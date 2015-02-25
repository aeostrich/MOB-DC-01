//
//  ViewController.swift
//  Data Persistence
//
//  Created by Adam Ostrich on 2/23/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let theme = defaults.objectForKey("theme") as String

        if theme == "dark" {
            self.view.backgroundColor = UIColor.blackColor()
            self.helloLabel.textColor = UIColor.whiteColor()
        }
        else {
            self.view.backgroundColor = UIColor.whiteColor()
            self.helloLabel.textColor = UIColor.blackColor()
        }
        
        defaults.setObject("light", forKey: "theme")
        
        
        var booksPath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
        // To read from data, use NSArray object
        var readBooks = NSArray(contentsOfFile: booksPath!)
        
        // To write to data, you NSMutableArray
        var writeBooks = NSMutableArray(contentsOfFile: booksPath!)
        
        println(readBooks!)
        
        writeBooks![2].setValue("Cinder the Fool: A Diatribe", forKey: "Title")
        writeBooks![2].setValue(400, forKey: "Pages")
        
        writeBooks?.writeToFile(booksPath!, atomically: true)
        
        // Read the books back out and see what happens
        readBooks = NSArray(contentsOfFile: booksPath!)
        
        println(readBooks!)
    }
}

