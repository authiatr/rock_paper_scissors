//
//  UserTests.swift
//  rpsTests
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHumanTypeInitialization() {
        let human = User(.human)
        XCTAssertEqual(human.type, .human)
    }
    
    func testBotTypeInitialization() {
        let bot = User(.bot)
        XCTAssertEqual(bot.type, .bot)
    }
    
    func testNextAttackAtInitialization() {
        let human = User(.human)
        XCTAssertNil(human.nextAttack)
    }
    
    func testNextAttackInitialization() {
        let human = User(.human)
        human.nextAttack = .rock
        XCTAssertEqual(human.nextAttack, .rock)
    }
    
    func testScoreInitialization() {
        let human = User(.human)
        XCTAssertEqual(human.score, 0)
    }
    
    func testScoreIncrement() {
        let human = User(.human)
        human.didWinARound()
        XCTAssertEqual(human.score, 1)
    }
}
