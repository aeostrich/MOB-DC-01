//
//  HangmanDelegate.swift
//  Hangman
//
//  Created by Adam Ostrich on 2/16/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

protocol HangmanDelegate {
    func setPhrase(phrase: String)
    func evaluateGuess(guess: String)
}