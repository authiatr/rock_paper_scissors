//
//  GameViewModel.swift
//  rps
//
//  Created by Robin on 07/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import UIKit

protocol GameViewModelDelegate: class {
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
    let userPlayer: User
    
    /// Opponent
    let botPlayer: User
    
    let isBotVsBot: Bool
    
    // MARK: Variables
    weak var delegate: GameViewModelDelegate?
    
    // MARK: - Custom init
    init?(game gamePlay: GamePlay) {
        guard gamePlay.players.count > 1 else {
            print("GameViewModel init(): Invalid gameplay because there isn't enough player")
            return nil
        }
        
        game = gamePlay
        userPlayer = gamePlay.players[0]
        botPlayer = gamePlay.players[1]
        isBotVsBot = game.containsOnlyBots()
    }
    
    // MARK: - Game methods
    
    func userDidPlay(_ attack: AttackType) {
        preprareBotsAttacks()
        
        userPlayer.nextAttack = attack
        
        startNextRound()
    }
    
    func startBotVsBotRound() {
        preprareBotsAttacks()
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
        
        // I allow myself to forcecast the optional nextAttack because
        // I check earlier in the guard statement of this method that everyoneIsReady()
        let firstUserAttack = userPlayer.nextAttack!
        let secondUserAttack = botPlayer.nextAttack!
        
        // Equality (same attack)
        guard firstUserAttack.rawValue != secondUserAttack.rawValue else {
            completion(nil)
            game.resetPlayersAttack()
            return
        }
        
        if firstUserAttack.isStrongerThan(secondUserAttack) {
            userPlayer.didWinARound()
            completion(userPlayer)
        } else {
            botPlayer.didWinARound()
            completion(botPlayer)
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
    
    func nameSentenceFor(_ player: User, info: String) -> String {
        return player.type.emoji() + "\n" + info
    }
    
    func scoreSentenceFor(_ player: User) -> String {
        return String(format: NSLocalizedString("game.score", comment: "Score sentence"), player.score, GamePlay.scoreGoal)
    }
    
    /// Check if the real user (not the bot opponent) win
    ///
    /// - Returns: True if he did, false if he lost
    func irlPlayerWin(_ gameWinner: User) -> Bool {
        return userPlayer === gameWinner
    }
}
