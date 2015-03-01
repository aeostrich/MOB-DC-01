//
//  ThirdViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBAction func pressNext(sender: UIBarButtonItem) {
        var tempPath = NSTemporaryDirectory() + "file.txt"
        var stringToSave = self.textView.text
        
        stringToSave.writeToFile(tempPath, atomically: true, encoding: NSUTF32StringEncoding, error: nil)
//        println("Wrote text to file \(tempPath)")
        
        // Segue
        self.performSegueWithIdentifier("showVC3to4", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
