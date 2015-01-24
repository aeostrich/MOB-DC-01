//
//  ViewController.swift
//  Assessment 3
//
//  Created by Tedi Konda on 1/22/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // BlackJack game: Create a a game of Blackjack
    // ************* Baseline requirements:
    // ** Set up Player class and CardGame class in their respective provided files. Follow the protocol rules for the CardGame class.
    // When card game first starts, a new player is generated and handed out 2 cards (between 1 and 11). Hint: generate 2 random numbers and add them together
    // A value for the CPU is also generated between 12 and 21 (random Int)
    // When the green view is double tapped (tap gesture recognizer), generate a new card (between 1 and 11) for the player, and add it to their score
    // If the total adds up to over 21, change the label text to "Game over, you lose!" and remove the ability for the player to keep tapping for cards
    // If the player wishes to not get dealt any more cards, the player can swipe right to end game (swipe gesture recognizer)
    // When the player ends the game, present the CPU score and present winner determined from compre comparison
    
    // Bonus: Create a button to play a new game.
    // Bonus 2: Player can start with a pool of money (selected through a text field) and make bets for each game (through a text field again). If player reaches <= 0, don't allow them to play any more games.
    // Bonus 3: When handing out cards, display the actual value to the user. If the card is an Ace, let the user select either 1 or 11.
    
    @IBOutlet weak var greenBox: UIView!
    @IBOutlet weak var dealerScoreLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var userPotLabel: UILabel!
    
    @IBOutlet weak var dealerOutput: UITextView!
    @IBOutlet weak var userOutput: UITextView!

    @IBOutlet weak var betAmount: UITextField!
    
    // Number of decks to use and the initial pot
    let numDecks: Int = 1
    let initialPot: Int = 100
    
    // Create a game with 1 deck and an initial pot of $100
    var game: CardGame
    // Used to track if there's a game in progress
    var gameOver: Bool = true
    
    override init() {
        game = CardGame(numDecks: self.numDecks, initialPot: self.initialPot)
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        game = CardGame(numDecks: self.numDecks, initialPot: self.initialPot)
        super.init(coder: aDecoder)
    }
    
    // Finish the game by marking that the game is over
    //  and outputting the proper messages
    func finishGame() {
        // Let the dealer have its turn
        // Only needs to happen if user didn't bust
        if self.game.user.highestScore() <= 21 {
            self.game.dealersTurn()
        }
        
        // Update display
        self.updateDisplay()
        
        // Mark that the game is over
        self.gameOver = true
        
        // Declare a winner
        var winnerOutput = self.game.declareWinner()
        println(winnerOutput)
        
        // Update labels
        self.userOutput.text = self.userOutput.text + winnerOutput.userOutput
        self.dealerOutput.text = self.dealerOutput.text + winnerOutput.dealerOutput
    }
    
    
    // Update hand, scores, and pot outputs
    func updateDisplay() {
        // Print the contents of the hands
        self.dealerOutput.text = game.dealer.printHand()
        self.userOutput.text = game.user.printHand()

        // Update the scores
        dealerScoreLabel.text = "Score: " + game.dealer.printTotal()
        userScoreLabel.text = "Score: " + game.user.printTotal()
        
        // Update pot
        self.userPotLabel.text = "Pot: $" + String(self.game.pot)
    }
    
    // Start New Game button starts a new game
    @IBAction func startNewGame(sender: AnyObject) {
        // Set the bet amount in stone
        if let val = self.betAmount.text.toInt() {
            self.game.currentBet = val
        }
        else {
            self.game.currentBet = 0
        }

        // Only start the game if the user has enough money to bet
        if (self.game.pot > 0) && (self.game.currentBet <= self.game.pot) {
            // Mark that the game is happening
            self.gameOver = false
            
            // Deal the first hand
            self.game.firstHand()
            
            // Update the displays
            self.updateDisplay()
            
            // Check for blackjack or other automatic win
            if (self.game.user.highestScore() == 21) || (self.game.dealer.highestScore() == 21) || ((self.game.dealer.highestScore() >= 17) && (self.game.user.highestScore() > self.game.dealer.highestScore())) {
                self.finishGame()
            }
        }
        // Print out error messages
        else {
            self.dealerOutput.text = ""
            if self.game.currentBet > self.game.pot {
                self.userOutput.text = "You can't bet more money than you have!\n"
            }
            else {
                self.userOutput.text = "Sorry, you don't have enough money to play"
            }
        }
    }
    
    
    
    @IBAction func hitMe(sender: UITapGestureRecognizer) {
        if !self.gameOver {
            // Give the user another card
            self.game.dealUser()
        
            // Update displays
            self.updateDisplay()
        
            // Check for bust, blackjack, or beating the dealer when they can't hit anymore
            if (self.game.user.highestScore() >= 21) || ((self.game.dealer.highestScore() >= 17) && (self.game.user.highestScore() > self.game.dealer.highestScore())) {
                self.finishGame()
            }
        }
    }
    
    // Finish the user's turn
    @IBAction func stay(sender: UISwipeGestureRecognizer) {
        if !self.gameOver {
            self.finishGame()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateDisplay()
    }


}

