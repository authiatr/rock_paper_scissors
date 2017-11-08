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
    func testPaperWinVersus() {
        let paper = AttackType.paper
        XCTAssertTrue(paper.isStrongerThan(.rock))
        XCTAssertTrue(paper.isStrongerThan(.spock))
    }
    
    func testPaperLooseVersus() {
        let paper = AttackType.paper
        XCTAssertTrue(paper.isWeakerThan(.scissors))
        XCTAssertTrue(paper.isWeakerThan(.lizard))
    }
    
    // Rock tests
    func testRockWinVersus() {
        let rock = AttackType.rock
        XCTAssertTrue(rock.isStrongerThan(.scissors))
        XCTAssertTrue(rock.isStrongerThan(.lizard))
    }
    
    func testRockLooseVersus() {
        let rock = AttackType.rock
        XCTAssertTrue(rock.isWeakerThan(.paper))
        XCTAssertTrue(rock.isWeakerThan(.spock))
    }
    
    // Scissors tests
    func testScissorsWinVersus() {
        let scissors = AttackType.scissors
        XCTAssertTrue(scissors.isStrongerThan(.paper))
        XCTAssertTrue(scissors.isStrongerThan(.lizard))
    }
    
    func testScissorsLooseVersus() {
        let scissors = AttackType.scissors
        XCTAssertTrue(scissors.isWeakerThan(.rock))
        XCTAssertTrue(scissors.isWeakerThan(.spock))
    }
    
    // Spock tests
    func testSpockWinVersus() {
        let spock = AttackType.spock
        XCTAssertTrue(spock.isStrongerThan(.scissors))
        XCTAssertTrue(spock.isStrongerThan(.rock))
    }
    
    func testSpockLooseVersus() {
        let spock = AttackType.spock
        XCTAssertTrue(spock.isWeakerThan(.lizard))
        XCTAssertTrue(spock.isWeakerThan(.paper))
    }
    
    // Lizard tests
    func testLizardWinVersus() {
        let lizard = AttackType.lizard
        XCTAssertTrue(lizard.isStrongerThan(.spock))
        XCTAssertTrue(lizard.isStrongerThan(.paper))
    }
    
    func testLizardLooseVersus() {
        let lizard = AttackType.lizard
        XCTAssertTrue(lizard.isWeakerThan(.scissors))
        XCTAssertTrue(lizard.isWeakerThan(.rock))
    }
}
