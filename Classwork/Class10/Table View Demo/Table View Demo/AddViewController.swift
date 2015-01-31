//
//  ViewController.swift
//  Table View Demo
//
//  Created by Adam Ostrich on 1/28/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

protocol Campus {
    func addCampusToArray(campusName: String)
}


class AddViewController: UIViewController {
    
    var delegate: Campus?
    
    @IBOutlet weak var inTextField: UITextField!
    
    
    @IBAction func addAndGoBack(sender: AnyObject) {
        self.delegate?.addCampusToArray(inTextField.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

