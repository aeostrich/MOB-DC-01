//
//  ViewController.swift
//  Robot Face
//
//  Created by Adam Ostrich on 2/9/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eyeWidth: NSLayoutConstraint!
    @IBOutlet weak var eyeHeight: NSLayoutConstraint!
    @IBOutlet weak var mouthHeight: NSLayoutConstraint!
    
    @IBAction func tapNose(sender: UITapGestureRecognizer) {
        println("Hey")
        self.mouthHeight.constant = 150
        UIView.animateKeyframesWithDuration(0.75, delay: 0, options: nil, animations: {self.view.layoutIfNeeded()}, completion: nil)
        
        self.mouthHeight.constant = 75
        UIView.animateWithDuration(0.75, delay: 0.75, options: nil, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    
    @IBAction func swipeMouth(sender: UISwipeGestureRecognizer) {
        println("Whoa!")
        let origEyeHeight = self.eyeHeight.constant
        let origEyeWidth = self.eyeWidth.constant
        
        self.eyeHeight.constant = origEyeHeight * 1.5
        self.eyeWidth.constant = origEyeWidth * 1.5
        UIView.animateKeyframesWithDuration(0.75, delay: 0, options: nil, animations: {self.view.layoutIfNeeded()}, completion: nil)

        self.eyeHeight.constant = origEyeHeight
        self.eyeWidth.constant = origEyeWidth
        UIView.animateKeyframesWithDuration(0.75, delay: 0.75, options: nil, animations: {self.view.layoutIfNeeded()}, completion: nil)

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

