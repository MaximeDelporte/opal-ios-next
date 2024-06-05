//
//  opal_iosTests.swift
//  opal-iosTests
//
//  Created by afx on 04/06/2024.
//

import Combine
import XCTest
@testable import opal_ios

final class SponsorshipViewModel_Tests: XCTestCase {
    
    func test_sponsorship_properties() {
        let reward = Reward.getReward(requiredFriends: 1)
        let sponsorship = Sponsorship(
            referredFriends: 0,
            rewards: [reward]
        )
        
        XCTAssertEqual(sponsorship.referredFriends, 0)
        
        let firstReward = sponsorship.rewards[0]
        XCTAssertEqual(firstReward.imageUrl, "loyal-gem")
        XCTAssertEqual(firstReward.requiredFriends, 1)
        XCTAssertEqual(firstReward.title, "Loyal Gem")
        XCTAssertEqual(firstReward.description, "Unlock this special milestone")
        XCTAssertFalse(firstReward.excludePremiums)
    }
    
    func test_whenSponsorshipRequestIsSuccessful_thenWeShouldHaveProperties() {
        // arrange
        let viewModel = SponsorshipViewModel()
        let spy = StateSpy(viewModel.statePublisher)
        
        // act
        viewModel.loadRewards()
        
        // assert
        XCTAssertEqual(spy.states.count, 2)
    }
}

private class StateSpy {
    
    private(set) var states = [SponsorshipViewModel.State]()
    private var cancellable: AnyCancellable?
    
    init(_ publisher: AnyPublisher<SponsorshipViewModel.State, Never>) {
        cancellable = publisher.sink(receiveValue: { [weak self] state in
            self?.states.append(state)
        })
    }
}
