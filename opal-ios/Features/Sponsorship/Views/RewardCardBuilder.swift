//
//  RewardCardBuilder.swift
//  opal-ios
//
//  Created by afx on 05/06/2024.
//

import Foundation

class RewardCardBuilder {
    
    let requirementText: String
    let titleText: String
    let descriptionText: String
    let imageUrl: String
    
    let ongoingMode: Bool
    
    init(reward: Reward) {
        self.requirementText = reward.requiredFriends > 1 ? "\(reward.requiredFriends) FRIENDS" : "\(reward.requiredFriends) FRIEND"
        self.titleText = reward.title
        self.descriptionText = reward.description
        self.imageUrl = reward.imageUrl
        
        
        self.ongoingMode = reward.status == Reward.Status.ongoing
    }
}
