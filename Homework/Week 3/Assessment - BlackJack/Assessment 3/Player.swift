//
//  Player.swift
//  Assessment 3
//
//  Created by Tedi Konda on 1/23/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import Foundation

class Player {
    // Default to empty hand
    var hand: Array<Card> = []
    
    // Potential total score for current hand
    var totals: Array<Int> = [0]    
    
    // To clear the hand, just empty hand array and reset totals array to 0
    func clearHand() {
        self.hand = []
        self.totals = [0]
    }
    
    // Add card to hand
    func addCard(card: Card) {
        self.hand += [card]
        
        // Recalculate the possible totals everytime you get a new card
        self.totals = calculatePossibleTotals()
    }
    
    // Calculate possible totals for the current hand
    private func calculatePossibleTotals() -> Array<Int> {
        var numAces = 0
        // First entry is base total
        var totals = [0]
        
        // Loop through all cards in the hand an add values to total
        // If the card is an ace, don't add the value, just mark how many
        // Possible values due to aces are calculated in the next section
        for card in self.hand {
            let val = card.effectiveValue()
            
            // Check to see if the card is an ace
            // For now, only add 1 for aces (deal with 11 case in next section)
            if val == 11 {
                totals[0] += 1
                numAces++
            }
            //Otherwise, just add the value
            else {
                totals[0] += val
            }
        }
        
        // Special processing for aces since they can be 1 or 11
        // Calculate all possible values for each ace == 11
        if numAces > 0 {
            
            // Calculate possible total for each ace
            // Note that I'm only adding 10 because 1 was already
            //  accounted for in the last section
            for i in 1...numAces {
                totals += [totals[0] + 10*i]
            }
            
            // Sort the array
            totals.sort({$0 < $1})
            
            // After the base total, remove any totals that create a bust
            // Relies on array being sorted from lowest to highest
            while (totals.count > 1) && (totals[totals.count-1] > 21) {
                totals.removeAtIndex(totals.count-1)
            }
        }
        
        return totals
    }
    

    // Return a string displaying the current hand contents
    func printHand() -> String {
        var result = ""
        
        // Just print each card onto its own line
        for card in self.hand {
            result += card.printCard() + "\n"
        }
        
        return result
    }
    
    // Return string indicating value of hand
    func printTotal() -> String {
        // Initialize result to string of base total
        //  which is the lowest possible value of the hand
        var result = String(self.totals[0])
        
        // Add other totals onto result string
        for index in 1..<self.totals.count {
            result += " or \(self.totals[index])"
        }
        
        return result
    }
    
    // Calculate highest possible score
    func highestScore() -> Int {
        // Array is sorted, highest score will always be at the end
        return self.totals[self.totals.count-1]
    }
}