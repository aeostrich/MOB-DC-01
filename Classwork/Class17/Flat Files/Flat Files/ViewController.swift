//
//  ViewController.swift
//  Flat Files
//
//  Created by Adam Ostrich on 2/25/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Accessing App/tmp
        var tempPath = NSTemporaryDirectory() + "hello.txt"
        println(tempPath)
        var stringToSave = self.textView.text
        
        var fileManager = NSFileManager()
        
        stringToSave.writeToFile(tempPath, atomically: true, encoding: NSUTF32StringEncoding, error: nil)
    }
    
    @IBAction func loadData(sender: UIButton) {
        var txtPath = NSTemporaryDirectory() + "hello.txt"
        var stringToLoad: NSString? = NSString(contentsOfFile: txtPath, encoding: NSUTF16StringEncoding, error: nil)
        
        if let loadedContent = stringToLoad {
            self.textView.text = loadedContent
        }
        else {
            println("Could not load!")
        }
    }
}

