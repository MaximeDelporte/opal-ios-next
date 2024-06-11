//
//  RewardCardLayout_Tests.swift
//  opal-iosTests
//
//  Created by afx on 05/06/2024.
//

import Foundation
import XCTest

@testable import opal_ios

class RewardCardLayout_Tests: XCTestCase {
    
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
    
    func test_verifyTheLayoutProperties() {
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
        
        XCTAssertEqual(layout.cardBackgroundColor, UIColor.white5)
        XCTAssertEqual(layout.cardBorderColor, UIColor.white10.cgColor)
        XCTAssertEqual(layout.descriptionColor, .white40)
        XCTAssertEqual(layout.rewardViewBackgroundColor, .white10)
        
        XCTAssertEqual(layout.cardCornerRadius, 18)
        XCTAssertEqual(layout.rewardStatus, .ongoing)
    }
    
    func test_backgroundColorShouldBeDifferent_whenOngoingStatusIsSet() {
        let statusAndColors: [(Reward.Status, UIColor)] = [
            (.todo, .black80),
            (.ongoing, .white5),
            (.claim, .black80),
            (.claimed, .black80)
        ]
        
        for (status, color) in statusAndColors {
            let reward = Reward.getReward(status: status)
            let layout = RewardCardLayout(reward: reward)
            XCTAssertEqual(layout.cardBackgroundColor, color)
        }
    }
}
