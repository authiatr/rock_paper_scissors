//
//  GameViewModel.swift
//  rps
//
//  Created by Robin on 07/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import UIKit

protocol GameViewModelDelegate {
    /// Call before the next round
    func prepareForTheNextRound()
    
    /// The round is win by one of the player
    ///
    /// - Parameter player: Round winner
    func userDidWinTheRound(_ player: User)
    
    /// The previous round did finish with an equality
    func roundFinishedWithAnEquality()
    
    /// Call if something wrong happen during the game
    func anErrorHappendDuringTheLastRound(_ error: String)
    
    /// Call when the game is over. Someone reach the maximum score
    ///
    /// - Parameter winner: Check if the first player did win
    func gameIsOver(_ didWin: Bool)
}

class GameViewModel: NSObject {
    // MARK: - Constants
    let game: GamePlay
    
    /// Can be a bot or a user but it represent the IRL player
    let firstUser: User
    
    /// Opponent
    let secondUser: User
    
    // MARK: Variables
    var delegate: GameViewModelDelegate?
    
    // MARK: - Custom init
    init?(game gamePlay: GamePlay) {
        guard gamePlay.players.count > 1 else {
            print("GameViewModel init(): Invalid gameplay because there isn't enough player")
            return nil
        }
        
        game = gamePlay
        firstUser = gamePlay.players[0]
        secondUser = gamePlay.players[1]
    }
    
    // MARK: - Game methods
    
    func userDidPlay(_ attack: AttackType) {
        preprareBotsAttacks()
        
        firstUser.nextAttack = attack
        
        startNextRound()
    }
    
    func startNextRound() {
        guard let delegate = delegate else {
            fatalError("GameViewModel - startNextRound(): The delegate isn't set")
        }
        
        // If the party is already over we don't want to continue
        if game.isOver(), let winner = game.winner() {
            delegate.gameIsOver(irlPlayerWin(winner))
            return
        }
        
        guard game.everyoneIsReady() else {
            print("GameViewModel - startNextRound(): Someone isn't ready")
            return
        }
        
        playNextRound(completion: { potentialWinner in
            if let winner = potentialWinner{
                delegate.userDidWinTheRound(winner)
            } else {
                delegate.roundFinishedWithAnEquality()
            }
        }, error: { errorMessage in
            delegate.anErrorHappendDuringTheLastRound(errorMessage)
        })
        
        if game.isOver(), let winner = game.winner() {
            delegate.gameIsOver(irlPlayerWin(winner))
        }
    }
    
    /// Play the next round of the game
    ///
    /// - Parameters:
    ///   - completion: Completion block who return the winner of the round or nil if there is equality
    ///   - error: Completion block if an anomalous happend
    func playNextRound(completion: (User?)->(), error: (String)->()) {
        guard game.everyoneIsReady() else {
            print("GameViewModel - playNextRound(): It looks like someone isn't ready")
            error("Someone isn't ready")
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
        
        // I allow myself to forcecast the optional nextAttack because
        // I check earlier in the guard statement of this method that everyoneIsReady()
        let firstUserAttack = firstUser.nextAttack!
        let secondUserAttack = secondUser.nextAttack!
        
        // Equality (same attack)
        guard firstUserAttack.rawValue != secondUserAttack.rawValue else {
            completion(nil)
            game.resetPlayersAttack()
            return
        }
        
        if firstUserAttack.isStrongerThan(secondUserAttack) {
            firstUser.didWinARound()
            completion(firstUser)
        } else {
            secondUser.didWinARound()
            completion(secondUser)
        }
        
        game.resetPlayersAttack()
    }
    
    /// Prepare the bots attack for the next round
    func preprareBotsAttacks() {
        game.players.forEach { user in
            if user.type == .bot {
                user.selectRandomAttack()
            }
        }
    }

    // MARK: - Utils
    
    func scoreSentenceFor(_ player: User) -> String {
        return String(format: NSLocalizedString("game.score", comment: "Score sentence"), player.score, GamePlay.scoreGoal)
    }
    
    /// Check if the real user (not the bot opponent) win
    ///
    /// - Returns: True if he did, false if he lost
    func irlPlayerWin(_ gameWinner: User) -> Bool {
        return firstUser === gameWinner
    }
}
