//
//  ViewController.swift
//  Documents
//
//  Created by Adam Ostrich on 2/25/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.layer.borderWidth = 2
    }
    
    func retrieveFilePath() -> String {
        let fileManager = NSFileManager()
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as [NSURL]
        
        if urls.count > 0 {
            let documentsFolder = urls[0]
            let savePath = documentsFolder.relativePath! + "/myfile.txt"
            println("Write file path: \(savePath)")
            return savePath
        }
        else {
            return ""
        }

    }

    
    @IBAction func saveData(sender: AnyObject) {
        let filePath = self.retrieveFilePath()
        
        if filePath != "" {
            self.textView.text?.writeToFile(filePath, atomically: true, encoding: NSUTF32StringEncoding, error: nil)
        }
        else {
            println("Couldn't find file to which to write")
        }
    }
    
    @IBAction func loadData(sender: UIButton) {
        let filePath = self.retrieveFilePath()
        println("Read file path: \(filePath)")
        
        if filePath != "" {
            var stringToLoad: NSString? = NSString(contentsOfFile: filePath, encoding: NSUTF32StringEncoding, error: nil)
            
            if let loadedContent = stringToLoad {
                self.textView.text = loadedContent
            }
            else {
                println("Could not load file content!")
            }
        }
        else {
            println("Couldn't find file from which to read")
        }
    }
}

