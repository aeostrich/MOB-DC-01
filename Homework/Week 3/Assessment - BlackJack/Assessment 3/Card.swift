//
//  Card.swift
//  Assessment 3
//
//  Created by Adam Ostrich on 1/24/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import Foundation

class Card {
    // Card value
    // It's a string to take face cards into account
    // Default all cards to the 2 of clubs
    var name: String = "2"
    var suit: String = "Clubs"
    
    // Useful for error checking
    let validSuits = ["Spades", "Hearts", "Clubs", "Diamonds"]
    let cardValues = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
    
    // The index indicates the card value from cardValues
    init(index: Int, suit: String) {
        // Error checking before setting everything
        // There are only 13 valid indices (2-Ace)
        if contains(0...12, index) && contains(validSuits, suit) {
            self.name = cardValues[index]
            self.suit = suit
        }
    }
    
    // Return the effective value of the card
    func effectiveValue() -> Int {
        // Check if value is between 2 and 10
        if contains(cardValues[0...8], name) {
            // Error checking shouldn't be necessary since it's all defined internally
            //  but I'll do it anyway...
            if let val = name.toInt() {
                return val
            }
            // Default to an effective value of 0
            else {
                return 0
            }
        }
        // Check if value is Jack, Queen, or King
        else if contains(cardValues[9...11], name) {
            return 10
        }
        // Otherwise, it's an ace
        else {
            return 11
        }
    }
    
    // Return a string describing the card
    func printCard() -> String {
        return "\(self.name) of \(self.suit)"
    }
    
    // Returns a string indicating the image file
    // representing that card
    func cardImage() -> String {
        var name: String = self.name
        
        // If the name is Jack, Queen, King, or Ace, we need to grab the first character
        if contains(cardValues[9...12], name) {
            name = String(name.lowercaseString[name.startIndex])
        }
        
        // Grab the first letter from the suit name and make it lowercase
        let firstSuitChar = self.suit.lowercaseString[self.suit.startIndex]
        return "\(self.name)\(firstSuitChar).jpg"
    }
}