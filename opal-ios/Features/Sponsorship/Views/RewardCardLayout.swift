//
//  RewardCardLayout.swift
//  opal-ios
//
//  Created by afx on 05/06/2024.
//

import Foundation
import UIKit

class RewardCardLayout {

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
    let titleColor: UIColor
    let descriptionColor: UIColor
    let progressViewBackgroundColor: UIColor
    let rewardViewBackgroundColor: UIColor
    
    let rewardViewSize: CGFloat
    let horizontalPadding: CGFloat
    let spaceBetweenImageAndContent: CGFloat
    let spaceBetweenTopAndContent: CGFloat
    let spaceBetweenRequirementAndTitle: CGFloat
    let spaceBetweenTitleAndDescription: CGFloat
    let progressViewHeight: CGFloat
    let spaceBetweenDescriptionAndProgressView: CGFloat
    let spaceBetweenDescriptionAndClaimButton: CGFloat
    let buttonHeight: CGFloat
    let spaceBetweenContentAndBottom: CGFloat
    
    let cardCornerRadius: CGFloat
    let ongoingMode: Bool
    
    private let reward: Reward
    
    init(reward: Reward) {
        self.reward = reward
        
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
        titleColor = .white
        descriptionColor = .white.withAlphaComponent(0.4)
        progressViewBackgroundColor = .white.withAlphaComponent(0.1)
        rewardViewBackgroundColor = .white.withAlphaComponent(0.1)
        
        rewardViewSize = 100
        horizontalPadding = 16
        spaceBetweenImageAndContent = 32
        spaceBetweenTopAndContent = 16
        spaceBetweenRequirementAndTitle = 4
        spaceBetweenTitleAndDescription = 4
        progressViewHeight = 6
        spaceBetweenDescriptionAndProgressView = 8
        spaceBetweenDescriptionAndClaimButton = 12
        buttonHeight = 32
        spaceBetweenContentAndBottom = 16
        
        cardCornerRadius = 18
        ongoingMode = reward.status == Reward.Status.ongoing
    }
    
    var isImageViewBiggerThanContent: Bool {
        let horizontalPaddings = horizontalPadding * 4
        let availableWidth = UIScreen.main.bounds.width - horizontalPaddings - rewardViewSize - spaceBetweenImageAndContent
        
        let requirementLabel = UILabel(font: requirementFont).numberOfLines(0)
        requirementLabel.text = requirementText
        let titleLabel = UILabel(font: titleFont).numberOfLines(0)
        titleLabel.text = titleText
        let descriptionLabel = UILabel(font: descriptionFont).numberOfLines(0)
        descriptionLabel.text = descriptionText
        
        var height = 0.0
        
        height += requirementLabel.heightForWidth(availableWidth)
        height += spaceBetweenRequirementAndTitle
        height += titleLabel.heightForWidth(availableWidth)
        height += spaceBetweenTitleAndDescription
        height += descriptionLabel.heightForWidth(availableWidth)
        
        if ongoingMode {
            height += spaceBetweenDescriptionAndProgressView
            height += progressViewHeight
        } else {
            height += spaceBetweenDescriptionAndClaimButton
            height += buttonHeight
        }
        
        return rewardViewSize >= height
    }
}
