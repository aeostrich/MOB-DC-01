//
//  ViewController.swift
//  class06Demo
//
//  Created by Adam Ostrich on 1/12/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    
    
    @IBAction func changeLabel(sender: AnyObject) {
        nameLabel.text = nameTextField.text
    }
    
    @IBAction func changeSliderLabel(sender: UISlider) {
        nameLabel.text = "Slider value: \(sender.value)"
    }
    
    // Function that gets loaded when the first scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("View did load")
    }

}