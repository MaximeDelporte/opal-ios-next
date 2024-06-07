//
//  SponsorshipViewLayout.swift
//  opal-ios
//
//  Created by afx on 06/06/2024.
//

import Foundation
import UIKit

class SponsorshipViewLayout {

    let addFriendsButtonImage: String
    let shareButtonImage: String
    
    let topCardLabelText: String
    let descriptionLabelText: String
    let addFriendsButtonText: String
    let shareButtontText: String
    let shareContentModaltext: String
    
    let topCardLabelFont: UIFont
    let descriptionLabelFont: UIFont
    
    let backgroundColor: UIColor
    let topCardBackgroundColor: UIColor
    let topCardLabelColor: UIColor
    let descriptionLabelColor: UIColor
    
    let horizontalPadding: CGFloat
    let topToCardView: CGFloat
    let cardViewToCardImageView: CGFloat
    let cardImageViewToCardLabel: CGFloat
    let cardLabelToBottomCardView: CGFloat
    let bottomCardViewToDescriptionLabel: CGFloat
    let addFriendsToFirstRewardCard: CGFloat
    let spaceBetweenCard: CGFloat
    let lastRewardCardToBottom: CGFloat
    
    let cardCornerRadius: CGFloat
    
    init() {
        addFriendsButtonImage = "person.crop.circle.badge.plus"
        shareButtonImage = "square.and.arrow.up"
        
        topCardLabelText = "30-day Guest Pass"
        descriptionLabelText = "Give a friend unlimited access to Opal Pro, including unlimited schedules, app limits, deep focus, whitelisting and more!"
        addFriendsButtonText = "Add Friends"
        shareButtontText = "Share Referral Link"
        shareContentModaltext = "Share Opal with your friends !"
        
        topCardLabelFont = .captionSemibold
        descriptionLabelFont = .calloutRegular
        
        backgroundColor = .black80
        topCardBackgroundColor = .purple
        topCardLabelColor = .white.withAlphaComponent(0.9)
        descriptionLabelColor = .white100
        
        horizontalPadding = 16
        topToCardView = 16
        cardViewToCardImageView = 64
        cardImageViewToCardLabel = 8
        cardLabelToBottomCardView = 64
        bottomCardViewToDescriptionLabel = 32
        addFriendsToFirstRewardCard = 32
        spaceBetweenCard = 16
        lastRewardCardToBottom = 32
        
        cardCornerRadius = 16
    }
}
