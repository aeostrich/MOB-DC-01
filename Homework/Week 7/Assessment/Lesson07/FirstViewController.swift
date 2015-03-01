//
//  FirstViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let testString = defaults.objectForKey("test_string") as String
        let testNumber = defaults.integerForKey("test_number")
        
        self.textView.text = "test_string: \(testString)\ntest_number: \(testNumber)"

    }
}