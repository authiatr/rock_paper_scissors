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
    
    func isStrongerThan() -> [AttackType] {
        switch self {
        case .rock:
            return [.scissors]
        case .paper:
            return [.rock]
        case .scissors:
            return [.paper]
        }
    }
    
    func isWeakerThan() -> [AttackType] {
        switch self {
        case .rock:
            return [.paper]
        case .paper:
            return [.scissors ]
        case .scissors:
            return [.rock]
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
}
