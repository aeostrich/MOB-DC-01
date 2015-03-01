//
//  FifthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBAction func pressNext(sender: UIBarButtonItem) {
        // Split contents of the text view
        var array: NSArray = split(self.textView.text) { $0 == " " }
        
        // Write the contents to a file
        var tempPath = NSTemporaryDirectory() + "array.txt"
        array.writeToFile(tempPath, atomically: true)
        

        // Perform segue
        self.performSegueWithIdentifier("showVC5to6", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
