//
//  ReferredViewController.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import Combine
import Foundation
import SnapKit
import UIKit

class SponsorshipViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let topCardView = UIView()
    private let topCardImageView = UIImageView()
    private let topCardLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    private let referredCard = UIView()
    private let addFriendsButton = UIButton()
    private let shareReferralLinkButton = UIButton()
    
    private var rewardCards = [RewardCard]()
    
    private var cancellable = Set<AnyCancellable>()
    private let viewModel = SponsorshipViewModel()
    
    private let layout = SponsorshipViewLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        setUpBindings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addFriendsButton.layer.cornerRadius = addFriendsButton.frame.height / 2
    }
}

// MARK: - Common Methods

extension SponsorshipViewController {
    
    private func setUpViews() {
        view.backgroundColor = layout.backgroundColor
        view.addSubview(scrollView)
        
        topCardView.backgroundColor = layout.topCardBackgroundColor
        topCardView.layer.cornerRadius = layout.cardCornerRadius
        
        topCardImageView.image = UIImage(named: "opal-title")
        
        topCardLabel.text = layout.topCardLabelText
        topCardLabel.font = layout.topCardLabelFont
        topCardLabel.textColor = layout.topCardLabelColor
        
        descriptionLabel.text = layout.descriptionLabelText
        descriptionLabel.font = layout.descriptionLabelFont
        descriptionLabel.textColor = layout.descriptionLabelColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        addFriendsButton.setTitle(layout.addFriendsText, for: .normal)
        addFriendsButton.setTitleColor(layout.addFriendsTextColor, for: .normal)
        addFriendsButton.backgroundColor = layout.addFriendsBackgroundColor
        
        topCardView.addSubview(topCardImageView)
        topCardView.addSubview(topCardLabel)
        
        scrollView.addSubview(topCardView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(addFriendsButton)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topCardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(layout.topToCardView)
            $0.left.equalTo(view).offset(layout.horizontalPadding)
            $0.right.equalTo(view).offset(-layout.horizontalPadding)
        }
        
        topCardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(layout.cardViewToCardImageView)
            $0.centerX.equalToSuperview()
        }
        
        topCardLabel.snp.makeConstraints {
            $0.top.equalTo(topCardImageView.snp.bottom).offset(layout.cardImageViewToCardLabel)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-layout.cardLabelToBottomCardView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(topCardView.snp.bottom).offset(layout.bottomCardViewToDescriptionLabel)
            $0.left.right.equalTo(topCardView)
        }
        
        addFriendsButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.left.right.equalTo(topCardView)
        }
    }
    
    private func setUpBindings() {
        addFriendsButton.addTarget(self, action: #selector(displayShareSheet), for: .touchUpInside)
        
        viewModel.statePublisher.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                break
            case .loaded(let sponsorship):
                self.addCards(from: sponsorship.rewards)
            }
        }).store(in: &cancellable)
        
        viewModel.loadRewards()
    }
}

// MARK: - Convenience Methods

extension SponsorshipViewController {
    
    @objc private func displayShareSheet() {
        let shareContent = layout.shareContentText
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    private func addCards(from rewards: [Reward]) {
        for reward in rewards {
            let layout = RewardCardLayout(reward: reward)
            let rewardCard = RewardCard(layout: layout)
            rewardCards.append(rewardCard)
        }
        
        setUpRewardCardsConstraints()
    }
    
    private func setUpRewardCardsConstraints() {
        for (index, rewardCard) in rewardCards.enumerated() {
            scrollView.addSubview(rewardCard)
            
            let isFirstCard = index == 0
            
            if isFirstCard {
                rewardCard.snp.makeConstraints {
                    $0.top.equalTo(addFriendsButton.snp.bottom).offset(layout.addFriendsToFirstRewardCard)
                    $0.left.right.equalTo(topCardView)
                }
            } 
            else {
                let isLastCard = index == rewardCards.count - 1
                let previousCard = rewardCards[index - 1]
                
                if isLastCard {
                    rewardCard.snp.makeConstraints {
                        $0.top.equalTo(previousCard.snp.bottom).offset(layout.spaceBetweenCard)
                        $0.left.right.equalTo(topCardView)
                        $0.bottom.equalToSuperview().offset(-layout.lastRewardCardToBottom)
                    }
                } else {
                    rewardCard.snp.makeConstraints {
                        $0.top.equalTo(previousCard.snp.bottom).offset(layout.spaceBetweenCard)
                        $0.left.right.equalTo(topCardView)
                    }
                }
            }
            
            rewardCard.updateLayout()
        }
    }
}

#Preview {
    SponsorshipViewController()
}
