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

    // MARK: - Public Properties
    
    var statePublisher: AnyPublisher<SponsorshipViewModel.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    func loadRewards() {
        let sponsorship = Bundle.main.decode(Sponsorship.self, from: "sponsorship.json")
        stateSubject.send(.loaded(sponsorship: sponsorship))
    }
}
