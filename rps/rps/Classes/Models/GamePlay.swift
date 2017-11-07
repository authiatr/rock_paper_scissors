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
