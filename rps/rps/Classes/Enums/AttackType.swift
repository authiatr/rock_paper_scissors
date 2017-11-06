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
    
    func isStrongerThan(_ attack: AttackType) -> Bool {
        switch self {
        case .rock:
            return [.scissors].contains(attack)
        case .paper:
            return [.rock].contains(attack)
        case .scissors:
            return [.paper].contains(attack)
        }
    }
    
    func isWeakerThan(_ attack: AttackType) -> Bool {
        switch self {
        case .rock:
            return [.paper].contains(attack)
        case .paper:
            return [.scissors ].contains(attack)
        case .scissors:
            return [.rock].contains(attack)
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
        case .scissors: allValues.append(.scissors)
        }
        return allValues
    }
}
