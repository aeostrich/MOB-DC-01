
//
//  SixthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var arrayPath = NSTemporaryDirectory() + "array.txt"
        var arrayToLoad: NSArray? = NSArray(contentsOfFile: arrayPath)
        
        if let loadedContent = arrayToLoad {
            let array = loadedContent as AnyObject as [String]
            self.textView.text = " ".join(array)
        }
        else {
            println("Could not load!")
        }
    }
}
