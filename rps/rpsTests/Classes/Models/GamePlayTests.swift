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
        XCTAssertNil(game)
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
        XCTAssertFalse(game!.everyoneIsReady())
    }
    
    func testEveryoneIsReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        bot.nextAttack = .paper
        XCTAssertTrue(game!.everyoneIsReady())
    }
    
    func testWhoIsNotReady() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        XCTAssertTrue(game!.whoIsNotReady().contains(bot))
    }
    
    func testEveryoneDidSetHerAttack() {
        let human = User(.human)
        let bot = User(.bot)
        let game = GamePlay(players: [ human, bot ])
        human.nextAttack = .rock
        bot.nextAttack = .paper
        XCTAssertTrue(game!.whoIsNotReady().isEmpty)
    }
    
    func testGameIsNotOver() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertFalse(game!.isOver())
    }
    
    func testGameShouldAutoPlay() {
        let bot1 = User(.bot)
        let bot2 = User(.bot)
        let game = GamePlay(players: [ bot1, bot2 ])
        XCTAssertTrue(game!.shouldAutoPlay())
    }
    
    func testGameShouldNotAutoPlay() {
        let game = GamePlay(players: [ human, bot ])
        XCTAssertFalse(game!.shouldAutoPlay())
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
