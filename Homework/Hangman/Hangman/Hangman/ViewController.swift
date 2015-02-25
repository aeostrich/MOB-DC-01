//
//  ViewController.swift
//  Hangman
//
//  Created by Adam Ostrich on 2/11/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HangmanDelegate {
    
    var hangmanView: UIView!
    
    var phraseLabel: UILabel!
    var guessButton: UIButton!
    var correctLabel: UILabel!
    var incorrectLabel: UILabel!
    
    // Hangman Drawing
    var gallowBase: UIView!
    var gallowPole: UIView!
    var gallowPlank: UIView!
    var head: UIView!
    var neck: UIView!
    var body: UIView!
    var leftArm: UIView!
    var rightArm: UIView!
    var leftLeg: UIView!
    var rightLeg: UIView!
    
    var numHangmanParts: Int = 0

    var newGameButton: UIButton!
    
    var gameOver: Bool = true
    
    var hangmanGame: HangmanGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.hangmanGame = HangmanGame()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameOverPlayerWin:", name: "gameOverPlayerWin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameOverPlayerOutOfGuesses:", name: "gameOverPlayerOutOfGuesses", object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.initializeHangmanDrawing()
    }
    
    
    
    func setPhrase(phrase: String) {
        self.hangmanGame.setPhrase(phrase)

        self.updateAllTheThings()
    }
    
    
    
    func evaluateGuess(guess: String) {
        self.hangmanGame.evaluateGuess(guess)

        self.updateAllTheThings()
    }
    
    
    
    func updateAllTheThings() {
        self.phraseLabel.text = self.hangmanGame.printPhrase()
        self.correctLabel.text = " Correct Guesses:" + self.hangmanGame.printCorrectGuesses()
        self.incorrectLabel.text = " Incorrect Guesses:" + self.hangmanGame.printIncorrectGuesses()
        self.updateHangmanDrawing()
        
        var result = self.hangmanGame.checkGameOver()
        
        if result.done {
            self.gameOver = true
            
            if result.condition == "Win" {
                NSNotificationCenter.defaultCenter().postNotificationName("gameOverPlayerWin", object: nil)
            }
            else {
                NSNotificationCenter.defaultCenter().postNotificationName("gameOverPlayerOutOfGuesses", object: nil)
            }
        }
    }
    
    
    
    func gameOverPlayerWin(notification: NSNotification) {
        let alert = UIAlertView()
        alert.title = "You won!"
        alert.addButtonWithTitle("Aw yeah")
        alert.show()
    }
    
    
    
    func gameOverPlayerOutOfGuesses(notification: NSNotification) {
        let alert = UIAlertView()
        alert.title = "You lost!"
        alert.message = "The phrase was:\n\(self.hangmanGame.phrase)"
        alert.addButtonWithTitle("I feel shame")
        alert.show()
    }
    
    
    
    func pressedNewGameButton(sender: UIButton) {
        self.numHangmanParts = 0
        self.resetHangmanDrawing()
        
        var newGameVC = NewGameViewController()
        newGameVC.delegate = self
        self.presentViewController(newGameVC, animated: true, completion: nil)
        
        self.gameOver = false
    }
    

    
    func pressedGuessButton(sender: UIButton) {
        if self.gameOver == false {
            var makeGuessVC = GuessViewController()
            makeGuessVC.delegate = self
            self.presentViewController(makeGuessVC, animated: true, completion: nil)
        }
    }
    
    
    
    /*
var gallowBase: UIView!
var gallowPole: UIView!
var head: UIView!
var neck: UIView!
var body: UIView!
var leftArm: UIView!
var rightArm: UIView!
var leftLeg: UIView!
var rightLeg: UIView!
*/




    func initializeHangmanDrawing() {
        if self.gallowBase == nil {
            self.gallowBase = UIView(frame: CGRect(x: 16, y: self.hangmanView.frame.height-20, width: self.hangmanView.frame.width/2, height: 10))
            self.gallowBase.backgroundColor = UIColor.darkGrayColor()
            self.gallowBase.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin
            self.hangmanView.addSubview(self.gallowBase)
        }
        
        
        // Gallow Pole
        if self.gallowPole == nil {
            self.gallowPole = UIView(frame: CGRect(x: 16+self.gallowBase.frame.width/2-5, y: 16, width: 10, height: self.hangmanView.frame.height-26))
            self.gallowPole.backgroundColor = UIColor.darkGrayColor()
            self.gallowPole.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
            self.hangmanView.addSubview(self.gallowPole)
        }
        
        // Gallow Plank
        if self.gallowPlank == nil {
            self.gallowPlank = UIView(frame: CGRect(x: 20+self.gallowBase.frame.width/2-5, y: 16, width: self.hangmanView.frame.width/3, height: 10))
            self.gallowPlank.backgroundColor = UIColor.darkGrayColor()
            self.gallowPlank.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
            self.hangmanView.addSubview(self.gallowPlank)
        }
    }
    
    func updateHangmanDrawing() {
        // Check that more hangman parts needs to be drawn
        if self.numHangmanParts < self.hangmanGame.incorrectGuesses.count {
            switch self.hangmanGame.incorrectGuesses.count {
                // Head
                case 1:
                    self.head = UIView(frame: CGRect(x: self.gallowPlank.frame.maxX-20, y: self.gallowPlank.frame.maxY, width: 40, height: self.hangmanView.frame.height/10))
                    self.head.layer.borderWidth = 5
                    self.head.layer.cornerRadius = 20
                    self.head.layer.borderColor = UIColor.blackColor().CGColor
                    self.head.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight
                    self.hangmanView.addSubview(self.head)
                // Neck
                case 2:
                    self.neck = UIView(frame: CGRect(x: self.gallowPlank.frame.maxX-5, y: self.gallowPlank.frame.maxY + self.hangmanView.frame.height/10, width: 10, height: self.hangmanView.frame.height/20))
                    self.neck.backgroundColor = UIColor.blackColor()
                    self.neck.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.neck)
                // Body
                case 3:
                    self.body = UIView(frame: CGRect(x: self.gallowPlank.frame.maxX-20, y: self.gallowPlank.frame.maxY+self.hangmanView.frame.height/10+self.hangmanView.frame.height/20, width: 40, height: self.hangmanView.frame.height*3/10))
                    self.body.layer.borderWidth = 5
                    self.body.layer.borderColor = UIColor.blackColor().CGColor
                    self.body.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.body)
                // Left Arm
                case 4:
                    self.leftArm = UIView(frame: CGRect(x: self.body.frame.minX - 7, y: self.body.frame.minY, width: 5, height: self.hangmanView.frame.height*7/20))
                    self.leftArm.backgroundColor = UIColor.blackColor()
                    self.leftArm.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.leftArm)
                // Right Arm
                case 5:
                    self.rightArm = UIView(frame: CGRect(x: self.body.frame.maxX+2, y: self.body.frame.minY, width: self.leftArm.frame.width, height: self.leftArm.frame.height))
                    self.rightArm.backgroundColor = UIColor.blackColor()
                    self.rightArm.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.rightArm)
                // Left Leg
                case 6:
                    self.leftLeg = UIView(frame: CGRect(x: self.body.frame.minX+10, y: self.body.frame.maxY, width: 5, height: self.hangmanView.frame.height*3/10))
                    self.leftLeg.backgroundColor = UIColor.blackColor()
                    self.leftLeg.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.leftLeg)
                // Right Leg
                case 7:
                    self.rightLeg = UIView(frame: CGRect(x: self.body.frame.maxX-15, y: self.body.frame.maxY, width: 5, height: self.hangmanView.frame.height*3/10))
                    self.rightLeg.backgroundColor = UIColor.blackColor()
                    self.rightLeg.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleTopMargin
                    self.hangmanView.addSubview(self.rightLeg)
                // Default, should never get here
                default:
                    println("Default")
            }
            
            self.numHangmanParts++
        }
    }
    
    func resetHangmanDrawing() {
        // Remove Head
        if self.head != nil {
            self.head.removeFromSuperview()
        }
        // Remove Neck
        if self.neck != nil {
            self.neck.removeFromSuperview()
        }
        // Remove Body
        if self.body != nil {
            self.body.removeFromSuperview()
        }
        // Remove Left Arm
        if self.leftArm != nil {
            self.leftArm.removeFromSuperview()
        }
        // Remove Right Arm
        if self.rightArm != nil {
            self.rightArm.removeFromSuperview()
        }
        // Remove Left Leg
        if self.leftLeg != nil {
            self.leftLeg.removeFromSuperview()
        }
        // Remove Right Leg
        if self.rightLeg != nil {
            self.rightLeg.removeFromSuperview()
        }
    }

    
    
    
    func initializeUI() {
        
        // Hangman View
        self.hangmanView = UIView(frame: CGRect(x: self.view.frame.width/15, y: 28, width: self.view.frame.width*13/15, height:self.view.frame.height-270))
        self.hangmanView.backgroundColor = UIColor.lightGrayColor()
        self.hangmanView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(self.hangmanView)
        
        // Phrase Label
        self.phraseLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.height-240, width: self.view.frame.width-32, height: 60))
        self.phraseLabel.text = ""
        self.phraseLabel.lineBreakMode = .ByWordWrapping
        self.phraseLabel.numberOfLines = 0
        self.phraseLabel.textAlignment = NSTextAlignment.Center
        self.phraseLabel.backgroundColor = MyColors.green()
        self.phraseLabel.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.phraseLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(self.phraseLabel)
        
        // Guess Button
        self.guessButton = UIButton(frame: CGRect(x: self.view.frame.width/5, y: self.view.frame.height - 170, width: self.view.frame.width * 3 / 5, height: 40))
        self.guessButton.setTitle("Guess a Letter", forState: .Normal)
        self.guessButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        self.guessButton.backgroundColor = MyColors.blue()
        self.guessButton.layer.cornerRadius = 10
        self.guessButton.addTarget(self, action: "pressedGuessButton:", forControlEvents: .TouchUpInside)
        self.guessButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.guessButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.guessButton.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        self.view.addSubview(self.guessButton)
        
        // Correct Label
        self.correctLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.height - 120, width: self.view.frame.width - 32, height: 30))
        self.correctLabel.text = " Correct Guesses:"
        self.correctLabel.backgroundColor = MyColors.green()
        self.correctLabel.font = UIFont(name: "MarkerFelt-Wide", size: 16)
        self.correctLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(self.correctLabel)

        
        // Incorrect Label
        self.incorrectLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.height - 90, width: self.view.frame.width - 32, height: 30))
        self.incorrectLabel.text = " Incorrect Guesses:"
        self.incorrectLabel.backgroundColor = MyColors.red()
        self.incorrectLabel.font = UIFont(name: "MarkerFelt-Wide", size: 16)
        self.incorrectLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(self.incorrectLabel)
        
        // New Game Button
        self.newGameButton = UIButton(frame: CGRect(x: 16, y: self.view.frame.height-50, width: self.view.frame.width - 32, height: 30))
        self.newGameButton.setTitle("Start a New Game", forState: .Normal)
        self.newGameButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 16)
        self.newGameButton.backgroundColor = MyColors.blue()
        self.newGameButton.layer.cornerRadius = 10
        self.newGameButton.addTarget(self, action: "pressedNewGameButton:", forControlEvents: .TouchUpInside)
        self.newGameButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.newGameButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.newGameButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(self.newGameButton)
    }
}

