//
//  GamePlayTests.swift
//  rpsTests
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import XCTest

class GamePlayTests: XCTestCase {
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
    
    func testGameContainsNotEnoughPlayers() {
        let game = GamePlay(players: [ human ])
        XCTAssertEqual(game, nil)
    }
    
    func testGameContainsMinimumPlayersCount() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertEqual(game!.players.count, 2)
    }
    
    func testSomeoneIsNotReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        bot.nextAttack = .paper
        XCTAssertEqual(game!.everyoneIsReady(), false)
    }
    
    func testEveryoneIsReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        bot.nextAttack = .paper
        XCTAssertEqual(game!.everyoneIsReady(), true)
    }
    
    func testWhoIsNotReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        XCTAssertEqual(game!.whoIsNotReady().contains(bot), true)
    }
    
    func testEveryoneDidSetHerAttack() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        bot.nextAttack = .paper
        XCTAssertEqual(game!.whoIsNotReady().isEmpty, true)
    }
    
    func testGameIsNotOver() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertEqual(game!.isOver(), false)
    }
    
    func testGameShouldAutoPlay() {
        let bot1 = User(.bot)
        let bot2 = User(.bot)
        let game = GamePlay(players: [ bot1, bot2 ])
        XCTAssertEqual(game!.shouldAutoPlay(), true)
    }
    
    func testGameShouldNotAutoPlay() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertEqual(game!.shouldAutoPlay(), false)
    }
    
    func testGameContainsOnlyBot() {
        let botOne = User(.bot)
        let botTwo = User(.bot)
        let game = GamePlay(players: [ botOne, botTwo ])
        XCTAssertTrue(game!.containsOnlyBots())
    }
    
    func testGameContainsAtLeastOneHuman() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertFalse(game!.containsOnlyBots())
    }
}
