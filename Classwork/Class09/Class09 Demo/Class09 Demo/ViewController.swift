//
//  ViewController.swift
//  Class09 Demo
//
//  Created by Adam Ostrich on 1/26/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBOutlet weak var swipeView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateRightSwipeOnRedBox()
        self.initiateDoubleTapOnRedBox()
    }
    
    // --------------------------------------------------
    // ======================
    // Swipe Right on Red Box
    // ======================
    
    func initiateRightSwipeOnRedBox() {
        // Colon after swipeRight says it's a method
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipedRight:")
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        self.swipeView.addGestureRecognizer(swipeRight)
    }
    
    // Must take a sender of the same type of gesture
    //  that's calling this function
    func swipedRight(sender: UISwipeGestureRecognizer) {
//        self.resultsLabel.text = "Swipe it, yo"
        
        // Changing functionality
        self.performSegueWithIdentifier("showSecondVC", sender: self)
    }
    
    // --------------------------------------------------
    // =====================
    // Double Tap on Red Box
    // =====================
    
    func initiateDoubleTapOnRedBox() {
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped:")
        
        doubleTap.numberOfTapsRequired = 2
        
        self.swipeView.addGestureRecognizer(doubleTap)
    }
    
    func doubleTapped(sender: UITapGestureRecognizer) {
//        let out = displayAlert(title: "Really important thing", message: "You did the double tap!", buttonText: "Aw yeah")
//        println(out)
//        self.resultsLabel.text = out
        
        // Changing functionality
        // Storyboard is an optional because code compiles
        //  before it pulls the storyboard in
        // Typecasting thirdVC to ThirdViewController
        println("about to get third vc from sb")
        var thirdVC = self.storyboard?.instantiateViewControllerWithIdentifier("thirdVC") as ThirdViewController
        
        println("about to present third vc")
        self.presentViewController(thirdVC, animated: true, completion: nil)
    }
    
    func displayAlert(#title: String, message: String, buttonText: String) -> String {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle(buttonText)
        alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        
//        alert.addAction(UIAlertAction(title: "Enter your password", style: UIAlertActionStyle.Default, handler: self.grabSecureText))
        
        alert.show()
        return ""
    }
    
    func grabSecureText(alertView: UIAlertAction!) {
    }


    
    // --------------------------------------------------

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

