//
//  AttackTests.swift
//  rpsTests
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import XCTest

class AttackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Paper tests
    func testPaperWinVersusRock() {
        let paper = AttackType.paper
        XCTAssertEqual(paper.isStrongerThan().contains(.rock), true)
    }
    
    func testPaperLooseVersusScissors() {
        let paper = AttackType.paper
        XCTAssertEqual(paper.isWeakerThan().contains(.scissors), true)
    }
    
    // Rock tests
    func testRockWinVersusScissors() {
        let rock = AttackType.rock
        XCTAssertEqual(rock.isStrongerThan().contains(.scissors), true)
    }
    
    func testRockLooseVersusPaper() {
        let rock = AttackType.rock
        XCTAssertEqual(rock.isWeakerThan().contains(.paper), true)
    }
    
    // Scissors tests
    func testScissorsWinVersusPaper() {
        let scissors = AttackType.scissors
        XCTAssertEqual(scissors.isStrongerThan().contains(.paper), true)
    }
    
    func testScissorsLooseVersusRock() {
        let scissors = AttackType.scissors
        XCTAssertEqual(scissors.isWeakerThan().contains(.rock), true)
    }
}
