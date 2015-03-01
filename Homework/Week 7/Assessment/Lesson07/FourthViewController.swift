//
//  FourthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        var txtPath = NSTemporaryDirectory() + "file.txt"
        var stringToLoad: NSString? = NSString(contentsOfFile: txtPath, encoding: NSUTF16StringEncoding, error: nil)
        
        if let loadedContent = stringToLoad {
            self.textView.text = loadedContent
        }
        else {
            println("Could not load!")
        }

    }
}
