//
//  CardGame.swift
//  Assessment 3
//
//  Created by Tedi Konda on 1/23/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import Foundation
protocol BlackJack {
    
    // Deal out the first hand
    func firstHand()
    
    // Deal a single card to a player
    func deal(player: Player)
}

class CardGame: BlackJack {
    var dealer: Player
    var user: Player
    var deck: Deck
    var pot: Int
    var numDecks: Int
    var currentBet: Int = 0
    
    // Default to user having 100 dollars
    init(numDecks: Int, initialPot: Int) {
        self.dealer = Player()
        self.user = Player()
        self.deck = Deck(numDecks: numDecks)
        
        self.pot = initialPot
        self.numDecks = numDecks
    }
        
    // Deal out the first hand
    // 2 cards for user, 2 cards for dealer
    // Start with user
    func firstHand() {
        // Set the bet
        self.pot -= self.currentBet
        
        // Automatically resetGame() when dealing the first hand
        self.resetGame()
        
        // First card
        self.dealUser()
        self.dealDealer()
        
        // Second card
        self.dealUser()
        self.dealDealer()
    }
    
    // Deal a single card to a player
    func deal(player: Player) {
        player.addCard(deck.dealCard())
    }
    
    // Deal to user
    func dealUser() {
        if self.user.highestScore() < 21 {
            self.deal(self.user)
        }
    }
    
    // Deal to dealer
    func dealDealer() {
        if self.dealer.highestScore() < 21 {
            self.deal(self.dealer)
        }
    }
    
    // Perform the entire dealer's turn
    func dealersTurn() {
        // Dealer hits with anything less than a 17
        // Only hits if the user hasn't already been beaten
        while (self.dealer.highestScore() < 17) && (self.dealer.highestScore() < self.user.highestScore())  {
            dealDealer()
        }
    }
    
    // Reset the game
    func resetGame() {
        // Reset the deck
        deck.reset(self.numDecks)
        
        // Clear everyone's hands
        dealer.clearHand()
        user.clearHand()
    }
    
    // Check to see if anyone busted
    func checkBust() -> (busted: Bool, winner: String) {
        var busted = false
        var winner = ""
        
        // User busts
        if user.highestScore() > 21 {
            busted = true
            winner = "Dealer"
        }
        // Dealer busts
        else if dealer.highestScore() > 21 {
            busted = true
            winner = "User"
        }
        
        return (busted, winner)
    }
    
    // Declare winner
    // Processes all of the final score stuff to determine who son
    func declareWinner() -> (dealerOutput: String, userOutput: String) {
        var winner: String = ""
        var newDealerOutput: String = ""
        var newUserOutput: String = ""
        var winnings: Int = 0
        

        // Check if anyone busted
        let bustResult = self.checkBust()

        // Take care of bust
        if bustResult.busted {
            winner = bustResult.winner
            
            // Let them know what happened
            if winner == "User" {
                println("The dealer busted!")
                newDealerOutput += "Oh no, you busted!\n"
            }
            else {
                println("The user busted!")
                newUserOutput += "Oh no, you busted!\n"
            }
        }
            // Otherwise, figure out the winner
        else {
            println("Here I am!")
            if self.user.highestScore() > self.dealer.highestScore() {
                println("Setting winner to user!")
                winner = "User"
            }
            else {
                println("Setting winner to dealer!")
                winner = "Dealer"
            }
        }
        
        
        // Declare the winner
        if winner == "User" {
            // Double the winning for blackjack
            if self.user.highestScore() == 21 {
                winnings = currentBet*4
            }
            else {
                winnings = currentBet*2
            }
            println("Declaring the user the winner!")
            newDealerOutput += "You lose\n"
            newUserOutput += "You win!\nYou just won $\(winnings)!"
            
            // Handle the money and update display
            self.pot += winnings
        }
        else if winner == "Dealer" {
            println("Declaring the dealer the winner!")
            newUserOutput += "You lose!\n"
            newDealerOutput += "You win\n"
        }
        
        return (newDealerOutput, newUserOutput)
    }
    
}