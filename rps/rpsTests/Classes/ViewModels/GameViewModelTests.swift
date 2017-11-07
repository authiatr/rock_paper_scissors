//
//  GameViewModelTests.swift
//  rpsTests
//
//  Created by Robin on 07/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import XCTest

class GameViewModelTests: XCTestCase {
    // MARK: Constants
    let human = User(.human)
    let bot = User(.bot)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testGameViewModelIsValid() {
        let game = GamePlay(players: [ human, bot ])
        let gameViewModel = GameViewModel(game: game!)
        XCTAssertNotNil(gameViewModel)
        XCTAssertNotNil(gameViewModel!.userPlayer)
        XCTAssertNotNil(gameViewModel!.botPlayer)
    }
    
    func testPlayerOrder() {
        let game = GamePlay(players: [ human, bot ])
        let gameViewModel = GameViewModel(game: game!)
        XCTAssertTrue(gameViewModel!.userPlayer === human)
        XCTAssertTrue(gameViewModel!.botPlayer === bot)
    }
    
    func testBotsAttackAreReady() {
        let firstBot = User(.bot)
        let secondBot = User(.bot)
        let game = GamePlay(players: [ firstBot, secondBot ])
        let gameViewModel = GameViewModel(game: game!)
        gameViewModel!.preprareBotsAttacks()
        XCTAssertNotNil(gameViewModel!.userPlayer.nextAttack)
        XCTAssertNotNil(gameViewModel!.botPlayer.nextAttack)
    }
    
    func testOnlyBotsAttackAreReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        let gameViewModel = GameViewModel(game: game!)
        gameViewModel!.preprareBotsAttacks()
        XCTAssertNil(gameViewModel!.userPlayer.nextAttack)
        XCTAssertNotNil(gameViewModel!.botPlayer.nextAttack)
    }
    
    func testGameIsOver() {
        // Can't check human vs bot because bot are playing randomly so I test with two human
        // Even if this mode doesn't exist
        let userPlayer = User(.human)
        let opponent = User(.human)
        let game = GamePlay(players: [ userPlayer, opponent ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            gameViewModel!.playNextRound(userAttack: .rock, botAttack: .paper, completion: { _ in })
        }
        XCTAssertTrue(game!.isOver())
    }
    
    func testIRLPlayerWon() {
        // Can't check human vs bot because bot are playing randomly so I test with two human
        // Even if this mode doesn't exist
        let userPlayer = User(.human) // Real player
        let opponent = User(.human)
        let game = GamePlay(players: [ userPlayer, opponent ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            gameViewModel!.playNextRound(userAttack: .rock, botAttack: .scissors, completion: { _ in })
        }
        let winner = game!.winner()
        XCTAssertTrue(game!.isOver())
        XCTAssertNotNil(winner)
        XCTAssertTrue(gameViewModel!.irlPlayerWin(winner!))
    }
    
    func testIRLPlayerLost() {
        // Can't check human vs bot because bot are playing randomly so I test with two human
        // Even if this mode doesn't exist
        let userPlayer = User(.human) // Real player
        let opponent = User(.human)
        let game = GamePlay(players: [ userPlayer, opponent ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            gameViewModel!.playNextRound(userAttack: .paper, botAttack: .scissors, completion: { _ in })
        }
        let winner = game!.winner()
        XCTAssertTrue(game!.isOver())
        XCTAssertNotNil(winner)
        XCTAssertFalse(gameViewModel!.irlPlayerWin(winner!))
    }
}
