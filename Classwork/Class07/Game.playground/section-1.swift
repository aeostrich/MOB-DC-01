// Playground - noun: a place where people can play

import UIKit

class Player {
    var health = 100
    var attackTypes: Array<(String,Int)>
    var name = ""
    
    init(name: String) {
        self.name = name
        self.attackTypes = [("Default", 0)]
    }
    
    func isAlive() -> Bool {
        return self.health > 0
    }
    
    func attack() -> (attackName: String, dmg: Int) {
        let attackNum = Int(arc4random_uniform(UInt32(attackTypes.count-1)))
        return attackTypes[attackNum]
    }
}

class GoodPlayer: Player {
    override init(name: String) {
        super.init(name: name)
        self.attackTypes = []
        self.attackTypes += [("Epic Light Storm", 70)]
        self.attackTypes += [("Magic missile", 30)]
        self.attackTypes += [("Punch of light", 25)]
        self.attackTypes += [("Poke", 5)]
    }
}

class BadPlayer: Player {
    override init(name: String) {
        super.init(name: name)
        self.attackTypes = []
        self.attackTypes += [("Evil Storm of Evil", 70)]
        self.attackTypes += [("Dark missile", 30)]
        self.attackTypes += [("Punch of Darkness", 25)]
        self.attackTypes += [("Lame Poke", 5)]
    }
}


class Match {
    var player1: Player
    var player2: Player
    
    init (player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func playGame() {
        var round = 0
        
        while self.player1.isAlive() && self.player2.isAlive() {
            println("Round \(round)!")
            println("\t\(self.player1.name): \(self.player1.health), \(self.player2.name): \(self.player2.health)")
            
            // Player 1 attacks on even rounds
            if round % 2 == 0 {
                let attack = self.player1.attack()
                println("\t\(self.player1.name) attacks with \(attack.attackName), does \(attack.dmg) points of damage\n")
                self.player2.health -= attack.dmg
            }
            // Player 2 attacjs on odd rounds
            else {
                let attack = self.player2.attack()
                println("\t\(self.player2.name) attacks with \(attack.attackName), does \(attack.dmg) points of damage\n")
                self.player1.health -= attack.dmg
            }
            
            round++
        }
        
        println("\n\nFIGHT OVER!")
        
        if self.player1.isAlive() {
            println("\(self.player1.name) wins!")
        }
        else {
            println("\(self.player2.name) wins!")
        }
    }
}

var goodPlayer = GoodPlayer(name: "Mr. Blue")
var badPlayer = BadPlayer(name: "Mr. Pink")
var match = Match(player1: goodPlayer, player2: badPlayer)

match.playGame()