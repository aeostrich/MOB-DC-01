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
    
    // TODO: Make notifications work!
    func gameOverPlayerWin(notification: NSNotification) {
        let alertController = UIAlertController(title: "Default Style", message: "A standard alert.", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func gameOverPlayerOutOfGuesses(notification: NSNotification) {
        
    }
    
    
    
    func pressedNewGameButton(sender: UIButton) {
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
    
    
    
    func initializeUI() {
        
        // Hangman View
        self.hangmanView = UIView(frame: CGRect(x: self.view.frame.width/5, y: 28, width: self.view.frame.width*3/5, height:self.view.frame.height-250))
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

