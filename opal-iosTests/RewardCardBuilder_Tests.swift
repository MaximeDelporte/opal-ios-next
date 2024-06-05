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
            let builder = RewardCardBuilder(reward: reward)
            
            XCTAssertEqual(builder.requirementText, expectedText)
        }
    }
    
    func test_verifyTheBuildersProperties() {
        let reward = Reward.getReward(requiredFriends: 5)
        let builder = RewardCardBuilder(reward: reward)
        
        XCTAssertEqual(builder.titleText, "Loyal Gem")
        XCTAssertEqual(builder.descriptionText, "Unlock this special milestone")
        XCTAssertEqual(builder.imageUrl, "loyal-gem")
        XCTAssertEqual(builder.claimButtonText, "Claim")
        
        XCTAssertEqual(builder.requirementFont, .captionSemibold)
        XCTAssertEqual(builder.titleFont, .bodyMedium)
        XCTAssertEqual(builder.descriptionFont, .footnoteSemibold)
        XCTAssertEqual(builder.claimButtonFont, .footnoteRegular)
        
        XCTAssertEqual(builder.cardBackgroundColor, UIColor(hex: "#141414")!)
        XCTAssertEqual(builder.cardBorderColor, UIColor.white.withAlphaComponent(0.1).cgColor)
        XCTAssertEqual(builder.descriptionColor, .white.withAlphaComponent(0.4))
        XCTAssertEqual(builder.progressViewBackgroundColor, .white.withAlphaComponent(0.1))
        XCTAssertEqual(builder.rewardViewBackgroundColor, .white.withAlphaComponent(0.1))
        
        XCTAssertEqual(builder.cardCornerRadius, 18)
        XCTAssertTrue(builder.ongoingMode)
    }
}
