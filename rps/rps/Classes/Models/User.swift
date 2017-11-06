//
//  User.swift
//  rps
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import Foundation

class User: NSObject {
    // MARK: - Constants
    let type: UserType
    
    // MARK: - Variables
    var score: Int = 0
    var nextAttack: AttackType?
    
    // MARK: - Custom init
    
    init(_ userType: UserType) {
        type = userType
    }
    
    // MARK: - Methods
    
    func didWinARound() {
        score += 1
    }
    
    func selectRandomAttack() {
        guard type == .bot else {
            print("User - selectRandomAttack(): Only the bots can use this method.")
            return
        }
            
        nextAttack = AttackType.allValues.randomItem()
    }
}
