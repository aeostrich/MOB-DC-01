//
//  ViewController.swift
//  Login Demo
//
//  Created by Adam Ostrich on 2/7/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var containerView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the background of the status bar gray
        var statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        statusBarView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(statusBarView)

        // Initialize the container for the rest of the screen
        containerView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height-20))
        containerView.backgroundColor = UIColor(red: 143/255, green: 214/255, blue: 219/255, alpha: 1.0)
        self.view.addSubview(containerView)
        
        // Initialize the container view label
        var containerViewLabel = UILabel(frame: CGRect(x: 50, y: 20, width: containerView.frame.width-100, height: 50))
        containerViewLabel.text = "Login Screen"
        containerViewLabel.textAlignment = NSTextAlignment.Center
        containerViewLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 32)
        containerView.addSubview(containerViewLabel)

        
        // Username text field
        var usernameTextField = UITextField(frame: CGRect(x: 25, y: 150, width: containerView.frame.width - 50, height: 40))
        usernameTextField.backgroundColor = UIColor.lightGrayColor()
        usernameTextField.borderStyle = UITextBorderStyle.RoundedRect
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        containerView.addSubview(usernameTextField)
        
        // Password text field
        var passwordTextField = UITextField(frame: CGRect(x: 25, y: 200, width: containerView.frame.width - 50, height: 40))
        passwordTextField.backgroundColor = UIColor.lightGrayColor()
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        passwordTextField.secureTextEntry = true
        passwordTextField.delegate = self
        containerView.addSubview(passwordTextField)
        
        // Login button
        var loginBtn = UIButton(frame: CGRect(x: 50, y: 260, width: containerView.frame.width-100, height: 50))
        loginBtn.backgroundColor = UIColor(red: 103/255, green: 144/255, blue: 236/255, alpha: 1.0)
        loginBtn.setTitle("Login", forState: .Normal)
        loginBtn.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 26)
        loginBtn.layer.cornerRadius = 20
        loginBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        loginBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        loginBtn.addTarget(self, action: "login", forControlEvents: .TouchUpInside)
        containerView.addSubview(loginBtn)
    }
    
    func login() {
        // Initialize see-through box
        var successView = UIView(frame: CGRect(x: 15, y: 125, width: self.containerView.frame.width-30, height: 225))
        successView.backgroundColor = UIColor.grayColor()
        successView.layer.cornerRadius = 20
        
        // Initialize text label
        var successLabel = UILabel(frame: CGRect(x: 15, y: 20, width: successView.frame.width - 30, height: 40))
        successLabel.text = "Successful Login!"
        successLabel.textAlignment = NSTextAlignment.Center
        successLabel.font = UIFont(name: "MarkerFelt-Wide", size: 32)
        
        // Dismiss button
        var dismissBtn = UIButton(frame: CGRect(x: 25, y: 130, width: successView.frame.width - 50, height: 50))
        dismissBtn.backgroundColor = UIColor(red: 103/255, green: 144/255, blue: 236/255, alpha: 1.0)
        dismissBtn.setTitle("Dismiss", forState: .Normal)
        dismissBtn.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 26)
        dismissBtn.layer.cornerRadius = 20
        dismissBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        dismissBtn.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        
        successView.addSubview(successLabel)
        successView.addSubview(dismissBtn)
        self.containerView.addSubview(successView)
    }
    
    func dismiss() {
        self.containerView.removeFromSuperview()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        login()
        
        return true
    }
    
}

