//
//  ViewController.swift
//  Networking Examples
//
//  Created by Adam Ostrich on 3/2/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Returns an optional because it verifies that the format is a valid url
        // Only analyzes the string, does not perform a DNS query
        let url = NSURL(string: "http://xkcd.com/404")
        
        // Completion handler options are arbitrary
        // Just defines the variables within the scope of the closure
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            var stringData: NSString
            if error != nil {
                stringData = error.localizedDescription
            }
            else {
                // Pass our NS Data return to a string
                stringData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            }
            println("Pants")
            // dataTaskWithURL launches a pthread
            // this call syncs the thread and the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.textView.text = stringData
            })

        })
        
        task.resume()
        println("Not pants")
    }
}

