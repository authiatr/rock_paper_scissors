//
//  AttackType.swift
//  rps
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import Foundation

enum AttackType: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
    case spock = "spock"
    case lizard = "lizard"
    
    func isStrongerThan(_ attack: AttackType) -> Bool {
        switch self {
        case .rock:
            return [.scissors, .lizard].contains(attack)
        case .paper:
            return [.rock, .spock].contains(attack)
        case .scissors:
            return [.paper, .lizard].contains(attack)
        case .spock:
            return [.scissors, .rock].contains(attack)
        case .lizard:
            return [.spock, .paper].contains(attack)
        }
    }
    
    func isWeakerThan(_ attack: AttackType) -> Bool {
        switch self {
        case .rock:
            return [.paper, .spock].contains(attack)
        case .paper:
            return [.scissors, .lizard ].contains(attack)
        case .scissors:
            return [.rock, .spock].contains(attack)
        case .spock:
            return [.paper, .lizard].contains(attack)
        case .lizard:
            return [.scissors, .rock].contains(attack)
        }
    }
    
    func emoji() -> String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "✋"
        case .scissors:
            return "✌"
        case .spock:
            return "🖖"
        case .lizard:
            return "👌"
        }
    }
    
    func localizedName() -> String {
        return NSLocalizedString(self.rawValue, comment: "Attack name translated")
    }
    
    // MARK: - Static variable
    
    static var allValues: [AttackType] {
        var allValues: [AttackType] = []
        switch (AttackType.rock) {
        case .rock: allValues.append(.rock); fallthrough
        case .paper: allValues.append(.paper); fallthrough
        case .scissors: allValues.append(.scissors); fallthrough
        case .spock: allValues.append(.spock); fallthrough
        case .lizard: allValues.append(.lizard)
        }
        return allValues
    }
}
