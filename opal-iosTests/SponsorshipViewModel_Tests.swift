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
    
    private var viewModel: SponsorshipViewModel!
    private var spy: StateSpy!
    
    override func setUp() {
        super.setUp()
        self.viewModel = SponsorshipViewModel()
        self.spy = StateSpy(viewModel.statePublisher)
    }
    
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
        // act
        viewModel.loadRewards()
        
        // assert
        XCTAssertEqual(spy.states.count, 2)
        
        guard case let .loaded(sponsorship) = spy.states[1] else {
            XCTFail("The second state should be loaded.")
            return
        }
        
        XCTAssertEqual(sponsorship.rewards.count, 6)
    }
    
    func test_getCompletionForReward_shouldReturnsCorrectValues() {
        // act
        viewModel.loadRewards()
        
        // assert
        let completionForRewardArray = getCompletionForRewardArray()
        
        for (completionShouldBe, reward) in completionForRewardArray {
            let completion = viewModel.getCompletion(for: reward)
            XCTAssertEqual(completionShouldBe, completion, "Completion should be: \(completionShouldBe) while it's \(completion) instead.")
        }
    }
}

// MARK: - Convenience Methods

extension SponsorshipViewModel_Tests {
    
    private func getCompletionForRewardArray() -> [(CGFloat, Reward)] {
        guard case let .loaded(sponsorship) = spy.states[1] else {
            XCTFail("The second state should be loaded.")
            return []
        }
        
        let claimedReward = sponsorship.rewards[0]
        let claimReward = sponsorship.rewards[1]
        let ongoingReward = sponsorship.rewards[2]
        let toDoReward1 = sponsorship.rewards[3]
        let toDoReward2 = sponsorship.rewards[4]
        let toDoReward3 = sponsorship.rewards[5]
        
        return [
            (1.0, claimedReward),
            (1.0, claimReward),
            (0.8, ongoingReward),
            (0.4, toDoReward1),
            (0.2, toDoReward2),
            (0.04, toDoReward3)
        ]
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
