//
//  RewardMock.swift
//  opal-iosTests
//
//  Created by afx on 05/06/2024.
//

import Foundation

@testable import opal_ios

extension Reward {
    
    static func getReward(requiredFriends: Int) -> Reward {
        Reward(
            imageUrl: "loyal-gem",
            requiredFriends: requiredFriends,
            title: "Loyal Gem",
            description: "Unlock this special milestone",
            excludePremiums: false,
            status: .ongoing
        )
    }
}
