//
//  RewardCardBuilder.swift
//  opal-ios
//
//  Created by afx on 05/06/2024.
//

import Foundation

class RewardCardBuilder {
    
    let requirementLabelText: String
    
    init(reward: Reward) {
        self.requirementLabelText = reward.requiredFriends > 1 ? "\(reward.requiredFriends) FRIENDS" : "\(reward.requiredFriends) FRIEND"
    }
}
