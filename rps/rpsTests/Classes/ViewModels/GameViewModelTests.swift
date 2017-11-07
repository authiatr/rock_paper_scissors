//
//  GameViewModelTests.swift
//  rpsTests
//
//  Created by Pitus on 07/11/2017.
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
        XCTAssertNotNil(gameViewModel!.firstUser)
        XCTAssertNotNil(gameViewModel!.secondUser)
    }
    
    func testPlayerOrder() {
        let game = GamePlay(players: [ human, bot ])
        let gameViewModel = GameViewModel(game: game!)
        XCTAssertTrue(gameViewModel!.firstUser === human)
        XCTAssertTrue(gameViewModel!.secondUser === bot)
    }
    
    func testBotsAttackAreReady() {
        let firstBot = User(.bot)
        let secondBot = User(.bot)
        let game = GamePlay(players: [ firstBot, secondBot ])
        let gameViewModel = GameViewModel(game: game!)
        gameViewModel!.preprareBotsAttacks()
        XCTAssertNotNil(gameViewModel!.firstUser.nextAttack)
        XCTAssertNotNil(gameViewModel!.secondUser.nextAttack)
    }
    
    func testOnlyBotsAttackAreReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        let gameViewModel = GameViewModel(game: game!)
        gameViewModel!.preprareBotsAttacks()
        XCTAssertNil(gameViewModel!.firstUser.nextAttack)
        XCTAssertNotNil(gameViewModel!.secondUser.nextAttack)
    }
    
    func testGameIsOver() {
        // Can't check human vs bot because bot are playing randomly so I test with two human
        let firstPlayer = User(.human)
        let secondPlayer = User(.human)
        let game = GamePlay(players: [ firstPlayer, secondPlayer ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            firstPlayer.nextAttack = .rock
            secondPlayer.nextAttack = .paper
            gameViewModel!.playNextRound(completion: { _ in }, error: { _ in })
        }
        XCTAssertTrue(game!.isOver())
    }
    
    func testIRLPlayerWon() {
        let firstPlayer = User(.human) // Real player
        let secondPlayer = User(.human)
        let game = GamePlay(players: [ firstPlayer, secondPlayer ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            firstPlayer.nextAttack = .rock
            secondPlayer.nextAttack = .scissors
            gameViewModel!.playNextRound(completion: { _ in }, error: { _ in })
        }
        let winner = game!.winner()
        XCTAssertTrue(game!.isOver())
        XCTAssertNotNil(winner)
        XCTAssertTrue(gameViewModel!.irlPlayerWin(winner!))
    }
    
    func testIRLPlayerLost() {
        let firstPlayer = User(.human) // Real player
        let secondPlayer = User(.human)
        let game = GamePlay(players: [ firstPlayer, secondPlayer ])
        let gameViewModel = GameViewModel(game: game!)
        
        for _ in 0..<GamePlay.scoreGoal {
            firstPlayer.nextAttack = .paper
            secondPlayer.nextAttack = .scissors
            gameViewModel!.playNextRound(completion: { _ in }, error: { _ in })
        }
        let winner = game!.winner()
        XCTAssertTrue(game!.isOver())
        XCTAssertNotNil(winner)
        XCTAssertFalse(gameViewModel!.irlPlayerWin(winner!))
    }
}
