//
//  UserViewController.swift
//  The Tweeting
//
//  Created by Adam Ostrich on 3/11/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    
    @IBOutlet weak var feedback: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    @IBAction func pressLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(self.usernameField.text, password: self.passwordField.text) { (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.feedback.text = "Successfully logged in!"

                self.performSegueWithIdentifier("login", sender: self)
            }
            else {
                self.feedback.text = "Error logging in!"
            }
        }
    }
    
    
    @IBAction func pressRegister(sender: AnyObject) {
        var user = PFUser()
        user.username = self.usernameField.text
        user.password = self.passwordField.text
        user.email    = self.usernameField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool!, error: NSError!) -> Void in
            if error == nil {
                self.feedback.text = "Successfully signed up!"
                self.usernameField.text = ""
                self.passwordField.text = ""
            }
            else {
                let errorString = error.userInfo?["error"] as? NSString
                self.feedback.text = errorString
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Better to normally make current user more global
        var currentUser = PFUser.currentUser()
        
        if currentUser != nil {
            println("You are logged in!")
            println(currentUser)
            self.usernameField.text = currentUser.username
        }
        else {
            println("Not logged in!")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
