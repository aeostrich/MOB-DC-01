//
//  HangmanGame.swift
//  Hangman
//
//  Created by Adam Ostrich on 2/11/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class HangmanGame {
    
    let alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    let allowedNumWrongGuesses = 6
    
    var correctGuesses: [Character] = []
    var incorrectGuesses: [Character] = []
    var phrase: String = ""
    
    func setPhrase(phrase: String) {
        self.correctGuesses = []
        self.incorrectGuesses = []
        self.phrase = phrase
    }
    
    func evaluateGuess(guess: String) {
        // Check that the string isn't empty
        if countElements(guess) > 0 {
            // Convert the guess to uppercase
            // In case the string has more than one character, only grab the first one
            var upperGuess = guess.uppercaseString[guess.startIndex]
        
            // Check that the guess is an alphabet letter
            if contains(self.alpha, upperGuess) {
                // Check that the letter is new
                if !contains(self.correctGuesses, upperGuess) && !contains(self.incorrectGuesses, upperGuess) {
                    // Check to see if the guess is in the phrase
                    if contains(phrase.uppercaseString, upperGuess) {
                        self.correctGuesses.append(upperGuess)
                        self.correctGuesses.sort({$0 < $1})
                    }
                    // Otherwise, add the guess as an incorrect guess
                    else {
                        self.incorrectGuesses.append(upperGuess)
                        self.incorrectGuesses.sort({$0 < $1})
                    }
                }
            }
        }
    }
    
    func checkGameOver() -> (done: Bool, condition: String) {
        // Check for loss
        if self.incorrectGuesses.count > self.allowedNumWrongGuesses {
            return (done: true, condition: "Lose")
        }
        
        // Check for win
        else {
            for char in phrase.uppercaseString {
                // If an alphabet character isn't in correctGuesses, the game isn't over
                if contains(self.alpha,char) && !contains(self.correctGuesses, char) {
                    return (done: false, condition: "Not over yet!")
                }
            }
        }
        
        // If we got here, no fail conditions matched, so we won the game!
        return (done: true, condition: "Win")
    }
    
    func printPhrase() -> String {
        var out: String = ""
        for char in self.phrase {
            // If the character is not an alphabet character or has already been guessed, print it
            //  For the second contains expression, I'm converting the character to an uppercase character
            if !contains(self.alpha, char) || contains(self.correctGuesses,Character(String(char).uppercaseString)) {
                out += "\(char) "
            }
            // Otherwise, print a blank space in which one can write their name
            else {
                out += "_ "
            }
        }
        return out

    }
    
    func printCorrectGuesses() -> String {
        var out: String = ""
        for char in self.correctGuesses {
            out += " \(char)"
        }
        return out
    }
    
    func printIncorrectGuesses() -> String {
        var out: String = ""
        for char in self.incorrectGuesses {
            out += " \(char)"
        }
        return out
    }
}