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
        XCTAssertTrue(paper.isStrongerThan(.rock))
    }
    
    func testPaperLooseVersusScissors() {
        let paper = AttackType.paper
        XCTAssertTrue(paper.isWeakerThan(.scissors))
    }
    
    // Rock tests
    func testRockWinVersusScissors() {
        let rock = AttackType.rock
        XCTAssertTrue(rock.isStrongerThan(.scissors))
    }
    
    func testRockLooseVersusPaper() {
        let rock = AttackType.rock
        XCTAssertTrue(rock.isWeakerThan(.paper))
    }
    
    // Scissors tests
    func testScissorsWinVersusPaper() {
        let scissors = AttackType.scissors
        XCTAssertTrue(scissors.isStrongerThan(.paper))
    }
    
    func testScissorsLooseVersusRock() {
        let scissors = AttackType.scissors
        XCTAssertTrue(scissors.isWeakerThan(.rock))
    }
}
