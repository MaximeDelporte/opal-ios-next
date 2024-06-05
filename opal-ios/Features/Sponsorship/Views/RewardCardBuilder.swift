//
//  RewardCardBuilder.swift
//  opal-ios
//
//  Created by afx on 05/06/2024.
//

import Foundation
import UIKit

class RewardCardBuilder {
    
    let requirementText: String
    let titleText: String
    let descriptionText: String
    let imageUrl: String
    let claimButtonText: String
    
    let requirementFont: UIFont
    let titleFont: UIFont
    let descriptionFont: UIFont
    let claimButtonFont: UIFont
    
    let cardBackgroundColor: UIColor
    let cardBorderColor: CGColor
    let descriptionColor: UIColor
    let progressViewBackgroundColor: UIColor
    let rewardViewBackgroundColor: UIColor
    
    let cardCornerRadius: CGFloat
    let ongoingMode: Bool
    
    init(reward: Reward) {
        self.requirementText = reward.requiredFriends > 1 ? "\(reward.requiredFriends) FRIENDS" : "\(reward.requiredFriends) FRIEND"
        self.titleText = reward.title
        self.descriptionText = reward.description
        self.imageUrl = reward.imageUrl
        self.claimButtonText = "Claim"
        
        self.requirementFont = .captionSemibold
        self.titleFont = .bodyMedium
        self.descriptionFont = .footnoteSemibold
        self.claimButtonFont = .footnoteRegular
        
        self.cardBackgroundColor = UIColor(hex: "#141414")!
        self.cardBorderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        self.descriptionColor = .white.withAlphaComponent(0.4)
        self.progressViewBackgroundColor = .white.withAlphaComponent(0.1)
        self.rewardViewBackgroundColor = .white.withAlphaComponent(0.1)
        
        self.cardCornerRadius = 18
        self.ongoingMode = reward.status == Reward.Status.ongoing
    }
}
