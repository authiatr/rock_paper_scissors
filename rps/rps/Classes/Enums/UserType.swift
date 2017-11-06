//
//  UserType.swift
//  rps
//
//  Created by Robin on 06/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import Foundation

enum UserType {
    case bot
    case human
    
    func emoji() -> String {
        switch self {
        case .bot:
            return "🤖"
        case .human:
            return "🤓"
        }
    }
}
