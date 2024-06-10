//
//  SponsorshipViewLayout.swift
//  opal-ios
//
//  Created by afx on 06/06/2024.
//

import Foundation
import UIKit

class SponsorshipViewLayout {

    let backgroundColor: UIColor
    let topBackgroundImage: String
    
    let guestPassCornerRadius: CGFloat
    let guestPassBackgroundImage: String
    let guestPassSealImage: String
    let guestPassTitleImage: String
    let guestPassDescriptionText: String
    let guestPassDescriptionTextColor: UIColor
    let guestPassDescriptionFont: UIFont
    
    let descriptionLabelText: String
    let descriptionLabelFont: UIFont
    let descriptionLabelColor: UIColor
    
    let buttonHeight: CGFloat
    let addFriendsButtonImage: String
    let addFriendsButtonText: String
    let shareButtonImage: String
    let shareButtontText: String
    
    let shareContentModaltext: String
    
    // Margins
    
    let horizontalPadding: CGFloat
    let topToGuestPassView: CGFloat
    let topGuestPassViewToGuestPassTitleImageView: CGFloat
    let guestPassTitleImageViewToGuestPassDescriptionLabel: CGFloat
    let guestPassDescriptionLabelToBottomGuestPassView: CGFloat
    let guestPassViewToDescriptionLabel: CGFloat
    let descriptionLabelToAddFriendsButtom: CGFloat
    let addFriendsButtonToShareReferralButton: CGFloat
    let firstRewardCardTopOffset: CGFloat
    let spaceBetweenRewardCards: CGFloat
    let lastRewardCardBottomOffset: CGFloat
    
    init() {
        backgroundColor = .black80
        topBackgroundImage = "purple-gradient"
        
        guestPassCornerRadius = 16
        guestPassBackgroundImage = "purple-gradient"
        guestPassSealImage = "opal-seal"
        guestPassTitleImage = "opal-title"
        guestPassDescriptionText = "30-day Guest Pass"
        guestPassDescriptionTextColor = .white.withAlphaComponent(0.9)
        guestPassDescriptionFont = .captionSemibold
        
        descriptionLabelText = "Give a friend unlimited access to Opal Pro, including unlimited schedules, app limits, deep focus, whitelisting and more!"
        descriptionLabelFont = .calloutRegular
        descriptionLabelColor = .white100
        
        buttonHeight = CGFloat.ButtonHeight.small
        addFriendsButtonImage = "person.crop.circle.badge.plus"
        addFriendsButtonText = "Add Friends"
        shareButtonImage = "square.and.arrow.up"
        shareButtontText = "Share Referral Link"
        
        shareContentModaltext = "Share Opal with your friends !"
        
        // Margins
        
        horizontalPadding = 16
        topToGuestPassView = 16
        topGuestPassViewToGuestPassTitleImageView = 64
        guestPassTitleImageViewToGuestPassDescriptionLabel = 8
        guestPassDescriptionLabelToBottomGuestPassView = 54
        guestPassViewToDescriptionLabel = 32
        descriptionLabelToAddFriendsButtom = 32
        addFriendsButtonToShareReferralButton = 8
        firstRewardCardTopOffset = 32
        spaceBetweenRewardCards = 16
        lastRewardCardBottomOffset = 32
    }
}
