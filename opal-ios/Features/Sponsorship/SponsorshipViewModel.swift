//
//  SponsorshipViewModel.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import Combine
import Foundation

class SponsorshipViewModel {
    
    enum State {
        case loading
        case loaded(sponsorship: Sponsorship)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private let stateSubject = CurrentValueSubject<SponsorshipViewModel.State, Never>(.loading)
    
    private var currentSponsorship: Sponsorship?

    // MARK: - Public Interface
    
    var statePublisher: AnyPublisher<SponsorshipViewModel.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    func loadRewards() {
        let sponsorship = Bundle.main.decode(Sponsorship.self, from: "sponsorship.json")
        currentSponsorship = sponsorship
        stateSubject.send(.loaded(sponsorship: sponsorship))
    }
    
    func getCompletion(for reward: Reward) -> CGFloat {
        guard let sponsorship = currentSponsorship else { return 0.0 }
        let result = CGFloat(sponsorship.referredFriends * 100) / CGFloat(reward.requiredFriends) / 100
        let roundedResult = result >= 1.0 ? 1.0 : result
        return roundedResult
    }
}
