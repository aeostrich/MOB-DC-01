//
//  ViewController.swift
//  To-Do_List
//
//  Created by Adam Ostrich on 1/28/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outTextView: UITextView!
    
    @IBOutlet weak var inTextField: UITextField!
    
    
    var toDoList: [String] = ["Feed the dog", "Buy some milk", "Wash the car", "Make it rain", "Buy some pickles", "Bring pickles to a party"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Array stuff
        self.toDoList.append("Code some apps, yo")
        self.printToDos()
    }
    
    func printToDos() {
        outTextView.text = "\n".join(self.toDoList)
    }
    
    @IBAction func addToDo(sender: AnyObject) {
        self.toDoList.append(self.inTextField.text)
        printToDos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

