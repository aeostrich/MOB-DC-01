//
//  Deck.swift
//  Assessment 3
//
//  Created by Adam Ostrich on 1/24/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import Foundation

class Deck {
    // Default to empty deck
    var cards: Array<Card> = []
    
    // Used for error checking
    let validSuits = ["Spades", "Hearts", "Clubs", "Diamonds"]


    // Intializing is the same thing as resetting the deck, so just call reset()
    init(numDecks: Int) {
        self.reset(numDecks)
    }
    
    // Reset function clears and repopultes the deck
    func reset(numDecks: Int) {
        // Initialize cards to empty array
        self.cards = []
        
        // Generate numDecks decks
        for i in 0..<numDecks {
            // Iterate over all possible index values for 2-Ace
            for valIndex in 0...12 {
                // Iterate over all possible suits
                for suit in validSuits {
                    self.cards += [Card(index: valIndex, suit: suit)]
                }
            }
        }
    }
    
    // Return a random card from the deck and remove it
    func dealCard() -> Card {
        // Randomly grab a card
        let cardIndex = Int(arc4random_uniform(UInt32(self.cards.count-1)))
        let returnCard = self.cards[cardIndex]
        
        // Remove the card from the current deck
        self.cards.removeAtIndex(cardIndex)
        
        // Return the card
        return returnCard
    }
}