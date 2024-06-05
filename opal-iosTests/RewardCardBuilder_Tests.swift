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
    
    func test_requirement_label_text() {
        let requireFriendsAndExpectedTexts = [
            (1, "1 FRIEND"),
            (2, "2 FRIENDS"),
            (10, "10 FRIENDS"),
        ]
        
        for (requireFriend, expectedText) in requireFriendsAndExpectedTexts {
            let reward = Reward.getReward(requiredFriends: requireFriend)
            let builder = RewardCardBuilder(reward: reward)
            
            XCTAssertEqual(builder.requirementLabelText, expectedText)
        }
    }
}
