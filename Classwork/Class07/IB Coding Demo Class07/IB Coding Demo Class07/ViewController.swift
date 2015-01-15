//
//  ViewController.swift
//  IB Coding Demo Class07
//
//  Created by Adam Ostrich on 1/14/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    
    @IBAction func createDog(sender: AnyObject) {
        var myDog = Dog(name: nameTextField.text)
        outputLabel.text = myDog.stringRepresentation()
    }
    
    @IBAction func createCat(sender: AnyObject) {
        var myCat = Cat(name: nameTextField.text)
        outputLabel.text = myCat.stringRepresentation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}