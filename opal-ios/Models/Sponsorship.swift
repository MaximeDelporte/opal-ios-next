//
//  Sponsorship.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import Foundation

struct Sponsorship: Decodable {
    
    let referredFriends: Int
    let rewards: [Reward]
    
    enum CodingKeys: String, CodingKey {
        case referredFriends = "referred_friends"
        case rewards
    }
}
