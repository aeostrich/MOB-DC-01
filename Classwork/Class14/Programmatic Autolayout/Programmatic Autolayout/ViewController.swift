//
//  ViewController.swift
//  Programmatic Autolayout
//
//  Created by Adam Ostrich on 2/11/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var head: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var body = UIView()
        body.backgroundColor = UIColor.greenColor()
        
        // Need to add subview before adding constraints
        self.view.addSubview(body)
        
        // This function states to no longer inherit constraints
        //  from springs and struts
        body.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        // Body Constraints
        let bodyWidth = NSLayoutConstraint(
            item: body,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.3,
            constant: 0.0
        )
        
        let bodyVerticalPosition = NSLayoutConstraint(
            item: body,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let bodyHorizontalPosition = NSLayoutConstraint(
            item: body,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let bodyDistanceFromBottom = NSLayoutConstraint(
            item: body,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -200
        )
        bodyDistanceFromBottom.priority = 800
        
        let bodyMinimumHeight = NSLayoutConstraint(
            item: body,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.GreaterThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.Height,
            multiplier: 1.0,
            constant: 150
        )


        self.view.addConstraints([bodyWidth, bodyVerticalPosition, bodyHorizontalPosition, bodyDistanceFromBottom, bodyMinimumHeight])
        
        
        // Left Arm
        var leftArm = UIView()
        leftArm.backgroundColor = self.head.backgroundColor
        self.view.addSubview(leftArm)
        leftArm.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Left Arm Constraints
        let leftArmRightEdge = NSLayoutConstraint(
            item: leftArm,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1.0,
            constant: 0
        )
        
        let leftArmTop = NSLayoutConstraint(
            item: leftArm,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let leftArmWidth = NSLayoutConstraint(
            item: leftArm,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.3,
            constant: 0.0
        )
        
        let leftArmDistanceFromBottomOfBody = NSLayoutConstraint(
            item: leftArm,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 30.0
        )

        self.view.addConstraints([leftArmRightEdge, leftArmTop
            , leftArmWidth, leftArmDistanceFromBottomOfBody])


        // Right Arm
        var rightArm = UIView()
        rightArm.backgroundColor = leftArm.backgroundColor
        self.view.addSubview(rightArm)
        rightArm.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Right Arm Constraints
        let rightArmLeftEdge = NSLayoutConstraint(
            item: rightArm,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightArmTop = NSLayoutConstraint(
            item: rightArm,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftArm,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightArmWidth = NSLayoutConstraint(
            item: rightArm,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftArm,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightArmBottom = NSLayoutConstraint(
            item: rightArm,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftArm,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        
        self.view.addConstraints([rightArmLeftEdge, rightArmTop
            , rightArmWidth, rightArmBottom])
        
        
        // Left Leg
        var leftLeg = UIView()
        leftLeg.backgroundColor = self.head.backgroundColor
        self.view.addSubview(leftLeg)
        leftLeg.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Left Leg Constraints
        let leftLegWidth = NSLayoutConstraint(
            item: leftLeg,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.2,
            constant: 0.0
        )
        
        let leftLegTop = NSLayoutConstraint(
            item: leftLeg,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let leftLegBottom = NSLayoutConstraint(
            item: leftLeg,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: -20.0
        )
        
        let leftLegLeftPosition = NSLayoutConstraint(
            item: leftLeg,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1.0,
            constant: self.view.frame.width * 0.3 / 6.0
        )
        
        self.view.addConstraints([leftLegWidth, leftLegTop, leftLegBottom, leftLegLeftPosition])
        
        
        // Right Leg
        var rightLeg = UIView()
        rightLeg.backgroundColor = leftLeg.backgroundColor
        self.view.addSubview(rightLeg)
        rightLeg.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Right Leg Constraints
        let rightLegWidth = NSLayoutConstraint(
            item: rightLeg,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftLeg,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightLegTop = NSLayoutConstraint(
            item: rightLeg,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftLeg,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightLegBottom = NSLayoutConstraint(
            item: rightLeg,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftLeg,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightLegLeftPosition = NSLayoutConstraint(
            item: rightLeg,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: body,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: -self.view.frame.width * 0.3 / 6.0
        )

        self.view.addConstraints([rightLegWidth, rightLegTop, rightLegBottom, rightLegLeftPosition])

        
        // Left Eye
        var leftEye = UIView()
        leftEye.backgroundColor = UIColor.whiteColor()
        self.head.addSubview(leftEye)
        leftEye.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Left Eye Constraints
        let leftEyeLeftLeading = NSLayoutConstraint(
            item: leftEye,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1.0,
            constant: self.head.frame.width / 6.0
        )
        
        let leftEyeLeftVerticalSpacing = NSLayoutConstraint(
            item: leftEye,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: self.head.frame.height / 4.0
        )
        
        let leftEyeHeight = NSLayoutConstraint(
            item: leftEye,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.125,
            constant: 0.0
        )

        let leftEyeWidth = NSLayoutConstraint(
            item: leftEye,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.125,
            constant: 0.0
        )

        self.head.addConstraints([leftEyeLeftLeading,leftEyeLeftVerticalSpacing,leftEyeHeight,leftEyeWidth])
     
        // Left Pupil
        var leftPupil = UIView()
        leftPupil.backgroundColor = UIColor.blackColor()
        leftEye.addSubview(leftPupil)
        leftPupil.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Left Pupil Constraints
        let leftPupilWidth = NSLayoutConstraint(
            item: leftPupil,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.4,
            constant: 0.0
        )
        
        let leftPupilHeight = NSLayoutConstraint(
            item: leftPupil,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.4,
            constant: 0.0
        )
        
        let leftPupilX = NSLayoutConstraint(
            item: leftPupil,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 0.0,
            constant: self.head.frame.width * 0.4 / 6.0
        )
        
        let leftPupilY = NSLayoutConstraint(
            item: leftPupil,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 0.0,
            constant: self.head.frame.height * 0.2 / 4.0
        )

        leftEye.addConstraints([leftPupilWidth,leftPupilHeight,leftPupilX,leftPupilY])

        // Right Eye
        var rightEye = UIView()
        rightEye.backgroundColor = UIColor.whiteColor()
        self.head.addSubview(rightEye)
        rightEye.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Right Eye Constraints
        let rightEyeRightTrailing = NSLayoutConstraint(
            item: rightEye,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: -self.head.frame.width / 6.0
        )
        
        let rightEyeVerticalSpacing = NSLayoutConstraint(
            item: rightEye,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.head,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: self.head.frame.height / 4.0
        )
        
        let rightEyeHeight = NSLayoutConstraint(
            item: rightEye,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.Height,
            multiplier: 1.0,
            constant: 0.0
        )
        
        let rightEyeWidth = NSLayoutConstraint(
            item: rightEye,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftEye,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0.0
        )
        
        self.head.addConstraints([rightEyeRightTrailing,rightEyeVerticalSpacing,rightEyeHeight,rightEyeWidth])

        // Right Pupil
        var rightPupil = UIView()
        rightPupil.backgroundColor = UIColor.blackColor()
        rightEye.addSubview(rightPupil)
        rightPupil.setTranslatesAutoresizingMaskIntoConstraints(false)

        // right Pupil Constraints
        let rightPupilWidth = NSLayoutConstraint(
            item: rightPupil,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: rightEye,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.4,
            constant: 0.0
        )
        
        let rightPupilHeight = NSLayoutConstraint(
            item: rightPupil,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: rightEye,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.4,
            constant: 0.0
        )
        
        let rightPupilX = NSLayoutConstraint(
            item: rightPupil,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: rightEye,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 0.0,
            constant: self.head.frame.width * 0.4 / 6.0
        )
        
        let rightPupilY = NSLayoutConstraint(
            item: rightPupil,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: rightEye,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 0.0,
            constant: self.head.frame.height * 0.2 / 4.0
        )

        rightEye.addConstraints([rightPupilWidth,rightPupilHeight,rightPupilX,rightPupilY])

    }
}

