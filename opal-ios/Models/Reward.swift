//
//  Reward.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import Foundation

struct Reward: Decodable {
    
    enum Status: Int, Decodable {
        case todo = 0
        case ongoing
        case claim
        case claimed
    }
    
    let imageUrl: String
    let requiredFriends: Int
    let title: String
    let description: String
    let excludePremiums: Bool
    let status: Reward.Status
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case requiredFriends = "required_friends"
        case title
        case description
        case excludePremiums = "exclude_premiums"
        case status
    }
    
    var isLocked: Bool {
        status == .todo || status == .ongoing
    }
}
