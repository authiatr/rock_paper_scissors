//
//  GamePlay.swift
//  rps
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import UIKit

class GamePlay: NSObject {
    // MARK: - Constants
    static let scoreGoal: Int = 5 // Could be set dynamically in the app
    let players: [User]
    
    // MARK: - Custom init
    init?(players users: [User]) {
        guard users.count > 1 else {
            print("GamePlay - init(players): A game need at least two users...")
            return nil
        }
        
        players = users
    }
    
    // MARK: Functions
    
    /// Play the next round of the game
    ///
    /// - Parameters:
    ///   - completion: Completion block who return the winner of the round or nil if there is equality
    ///   - notReady: Completion block if at least one User isn't ready
    func playNextRound(_ completion: (User?)->(), notReady: ([User])->()) {
        guard everyoneIsReady() else {
            print("GamePlay - playNextRound(): It looks like someone isn't ready")
            notReady(whoIsNotReady())
            return
        }
        
        // Compare the attacks. I'm gonna assume there is ONLY 2 players in the game right now.
        // To handle more than two player we should create the missing score rules
        // Example:
        // Player 1 Attack -> paper
        // Player 2 Attack -> rock
        // Player 3 Attack -> scissors
        // Result:
        // Player 1 win vs Player 2 but loose vs Player 3
        // Player 2 win vs Player 3 but loose vs Player 1
        // Player 3 win vs Player 1 but loose vs Player 2 -> Who win points??
        
        // A GamePlay object isn't valid with less than two players, index can't be out of array bounds
        let firstUser = players[0]
        let secondUser = players[1]
        
        // I allow myself to forcecast the optional nextAttack because
        // I check earlier in the guard statement of this method than everyoneIsReady()
        let firstUserAttack = firstUser.nextAttack!
        let secondUserAttack = secondUser.nextAttack!
        
        // Equality (same attack)
        guard firstUserAttack.rawValue != secondUserAttack.rawValue else {
            completion(nil)
            resetPlayersAttack()
            return
        }
        
        if firstUserAttack.isStrongerThan(secondUserAttack) {
            firstUser.didWinARound()
            completion(firstUser)
        } else {
            secondUser.didWinARound()
            completion(secondUser)
        }
        
        resetPlayersAttack()
    }
    
    /// Check if the players have their next attack set
    ///
    /// - Returns: true if they are ready, false if they aren't
    func everyoneIsReady() -> Bool {
        return whoIsNotReady().isEmpty
    }
    
    /// Check if one user did reach the final score
    ///
    /// - Returns: true if someone reach the final score
    func isOver() -> Bool {
        for player in players {
            if player.score == GamePlay.scoreGoal {
                return true
            }
        }
        
        return false
    }
    
    /// Check if the game should play "alone". If there is no human in the party the should not wait user interactions
    ///
    /// - Returns: true if the game contains only bot players, false if there is at least one human
    func shouldAutoPlay() -> Bool {
        let botsCount = players.filter{ $0.type == .bot }.count
        
        return botsCount == players.count
    }
    
    /// Return the list of all unready user
    ///
    /// - Returns: Users not ready array
    func whoIsNotReady() -> [User] {
        return players.filter{ $0.nextAttack == nil }
    }
    
    /// Reset the players attack
    func resetPlayersAttack() {
        players.forEach{ $0.nextAttack = nil }
    }
}
