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
    
    let rewardViewSize: CGFloat
    let horizontalPadding: CGFloat
    let spaceBetweenImageAndContent: CGFloat
    let spaceBetweenRequirementAndTitle: CGFloat
    let spaceBetweenTitleAndDescription: CGFloat
    let progressViewHeight: CGFloat
    let spaceBetweenDescriptionAndProgressView: CGFloat
    let spaceBetweenDescriptionAndClaimButton: CGFloat
    let spaceBetweenLastComponentAndBottom: CGFloat
    
    let cardCornerRadius: CGFloat
    let ongoingMode: Bool
    
    init(reward: Reward) {
        requirementText = reward.requiredFriends > 1 ? "\(reward.requiredFriends) FRIENDS" : "\(reward.requiredFriends) FRIEND"
        titleText = reward.title
        descriptionText = reward.description
        imageUrl = reward.imageUrl
        claimButtonText = "Claim"
        
        requirementFont = .captionSemibold
        titleFont = .bodyMedium
        descriptionFont = .footnoteSemibold
        claimButtonFont = .footnoteRegular
        
        cardBackgroundColor = UIColor(hex: "#141414")!
        cardBorderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        descriptionColor = .white.withAlphaComponent(0.4)
        progressViewBackgroundColor = .white.withAlphaComponent(0.1)
        rewardViewBackgroundColor = .white.withAlphaComponent(0.1)
        
        rewardViewSize = 100
        horizontalPadding = 16
        spaceBetweenImageAndContent = 32
        spaceBetweenRequirementAndTitle = 4
        spaceBetweenTitleAndDescription = 4
        progressViewHeight = 6
        spaceBetweenDescriptionAndProgressView = 8
        spaceBetweenDescriptionAndClaimButton = 12
        spaceBetweenLastComponentAndBottom = 12
        
        cardCornerRadius = 18
        ongoingMode = reward.status == Reward.Status.ongoing
    }
}
