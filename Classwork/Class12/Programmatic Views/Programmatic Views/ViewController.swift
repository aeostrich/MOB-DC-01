//
//  ViewController.swift
//  Programmatic Views
//
//  Created by Adam Ostrich on 2/6/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var blueBox = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        blueBox.backgroundColor = UIColor.blueColor()
        blueBox.layer.cornerRadius = 20
        blueBox.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin
        self.view.addSubview(blueBox)
        
        var blueBoxLabel = UILabel(frame: CGRect(x: 10, y: 50, width: blueBox.frame.width - 20, height: 30))
        blueBoxLabel.text = "Hello world"
        blueBoxLabel.textColor = UIColor.blackColor()
        blueBoxLabel.font = UIFont.boldSystemFontOfSize(24)
        blueBoxLabel.textAlignment = NSTextAlignment.Center
        blueBoxLabel.backgroundColor = UIColor.greenColor()
        blueBox.addSubview(blueBoxLabel)
        
        
        var actionBtn = UIButton(frame: CGRect(x: 10, y: 300, width: self.view.frame.width-20, height: 30))
        actionBtn.setTitle("Click me!", forState: .Normal)
        actionBtn.addTarget(self, action: "pressedCodedBtn:", forControlEvents: .TouchUpInside)
        actionBtn.backgroundColor = UIColor.purpleColor()
        actionBtn.layer.cornerRadius = 10
        actionBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        actionBtn.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(actionBtn)
        
        
        var charlieImg = UIImage(named: "Charleston.jpg")
        var charlieImgView = UIImageView(image: charlieImg)
        charlieImgView.frame = CGRect(x: 50, y: 350, width: charlieImg!.size.width/2, height: charlieImg!.size.height/2)
        charlieImgView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(charlieImgView)
    }
    
    func pressedCodedBtn(sender: UIButton) {
        println("Fuck yeah")
        sender.removeFromSuperview()
    }

}

