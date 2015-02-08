//
//  FirstViewController.swift
//  view demos
//
//  Created by Adam Ostrich on 1/21/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var mySquare: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animateWithDuration(1.5, animations: {
            self.mySquare.backgroundColor = UIColor.redColor()
            // alpha == transparency
            // VERY EXPENSIVE, YO
            self.mySquare.alpha = 0.5
        })
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func swipeSquareRight(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(1.5, animations: {
            self.mySquare.backgroundColor = UIColor.greenColor()
            self.mySquare.alpha = 1.0
        })
    }
    @IBAction func swipeSquareLeft(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(1.5, animations: {
            self.mySquare.backgroundColor = UIColor.redColor()
            self.mySquare.alpha = 0.5
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
