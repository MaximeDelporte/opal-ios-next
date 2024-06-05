//
//  RewardCardBuilder_Tests.swift
//  opal-iosTests
//
//  Created by afx on 05/06/2024.
//

import Foundation
import XCTest

@testable import opal_ios

class RewardCardBuilder_Tests: XCTestCase {
    
    func test_requirementTextShouldChange_dependingOfRequireFriendsValue() {
        let requireFriendsAndExpectedTexts = [
            (1, "1 FRIEND"),
            (2, "2 FRIENDS"),
            (10, "10 FRIENDS")
        ]
        
        for (requireFriends, expectedText) in requireFriendsAndExpectedTexts {
            let reward = Reward.getReward(requiredFriends: requireFriends)
            let builder = RewardCardLayout(reward: reward)
            
            XCTAssertEqual(builder.requirementText, expectedText)
        }
    }
    
    func test_verifyTheBuildersProperties() {
        let reward = Reward.getReward(requiredFriends: 5)
        let layout = RewardCardLayout(reward: reward)
        
        XCTAssertEqual(layout.titleText, "Loyal Gem")
        XCTAssertEqual(layout.descriptionText, "Unlock this special milestone")
        XCTAssertEqual(layout.imageUrl, "loyal-gem")
        XCTAssertEqual(layout.claimButtonText, "Claim")
        
        XCTAssertEqual(layout.requirementFont, .captionSemibold)
        XCTAssertEqual(layout.titleFont, .bodyMedium)
        XCTAssertEqual(layout.descriptionFont, .footnoteSemibold)
        XCTAssertEqual(layout.claimButtonFont, .footnoteRegular)
        
        XCTAssertEqual(layout.cardBackgroundColor, UIColor(hex: "#141414")!)
        XCTAssertEqual(layout.cardBorderColor, UIColor.white.withAlphaComponent(0.1).cgColor)
        XCTAssertEqual(layout.descriptionColor, .white.withAlphaComponent(0.4))
        XCTAssertEqual(layout.progressViewBackgroundColor, .white.withAlphaComponent(0.1))
        XCTAssertEqual(layout.rewardViewBackgroundColor, .white.withAlphaComponent(0.1))
        
        XCTAssertEqual(layout.cardCornerRadius, 18)
        XCTAssertTrue(layout.ongoingMode)
    }
}
