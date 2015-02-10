//
//  ViewController.swift
//  Autolayout
//
//  Created by Adam Ostrich on 2/9/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var verticalSpacingBetweenPurpleGhostAndPacman: NSLayoutConstraint!

    @IBOutlet weak var purpleGhost: UIView!
    @IBOutlet weak var greenButton: UIButton!
    let move = CGFloat(80)
    
    @IBAction func IncreaseDistanceBetweenPacmanAndGhost(sender: AnyObject) {
        println(greenButton.frame.maxY)
        println(purpleGhost.frame.minY - move)
        if (greenButton.frame.maxY > (purpleGhost.frame.minY - move)) {
            self.verticalSpacingBetweenPurpleGhostAndPacman.constant += move
            
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else {
            println("Hey!")
            let diff = greenButton.frame.maxY - purpleGhost.frame.minY + move
            self.verticalSpacingBetweenPurpleGhostAndPacman.constant += move - diff
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.verticalSpacingBetweenPurpleGhostAndPacman.constant -= diff
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
            })


            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

