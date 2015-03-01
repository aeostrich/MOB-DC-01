//
//  SecondViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var name: String = ""
        var slider: Double = 0.0

        var readSettings: NSDictionary?
        var settingsPath = NSBundle.mainBundle().pathForResource("Settings.bundle/Root", ofType: "plist")
//        println(settingsPath)
        
        // To read from data, use NSArray object
        if let path = settingsPath {
//            println("Unwrapped settingsPath")
            readSettings = NSDictionary(contentsOfFile: path)
            // Unwrap settings
            if let dict = readSettings {
//                println("Unwrapped readSettings")
                // Unwrap PreferenceSpecifiers
                if let preferenceSpecifiers: NSArray = dict["PreferenceSpecifiers"] as NSArray? {
//                    println("Unwrapped preferenceSpecifiers")
                    // Unwrap name
                    if let unwrappedName = preferenceSpecifiers[1]["Title"] as String? {
                        name = unwrappedName
                    }
                    else {
                        println("Couldn't unwrap settings_name")
                    }
                    
                    // Unwrap slider
                    if let unwrappedSlider: Double = preferenceSpecifiers[2]["DefaultValue"] as Double? {
                        slider = unwrappedSlider
                    }
                    else {
                        println("Couldn't unwrap settings_slider")
                    }
                }
                else {
                    println("Couldn't unwrap preferenceSpecifiers")
                }
                
            }
            else {
                println("Could not unwrap readSettings")
            }
        }
        else {
            println("Could not unwrap settingsPath!")
        }
        
        // Set the text view
        self.textView.text = "Name:   \(name)\nSlider: \(slider)"
    }
}
