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
    private let topBackgroundImageView = UIImageView()
    
    // Guest Pass
    private let guestPassView = UIView()
    private let guestPassBackgroundImageView = UIImageView()
    private let guestPassSealImageView = UIImageView()
    private let guestPassTitleImageView = UIImageView()
    private let guestPassDescriptionLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    private let referredCard = UIView()
    
    private lazy var addFriendsButton = UIButton.primary(
        title: layout.addFriendsButtonText,
        imageName: layout.addFriendsButtonImage
    )
    
    private lazy var shareReferralButton = UIButton.tertiary(
        title: layout.shareButtontText,
        imageName: layout.shareButtonImage
    )
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Common Methods

extension SponsorshipViewController {
    
    private func setUpViews() {
        view.backgroundColor = layout.backgroundColor
        view.addSubview(scrollView)
        
        topBackgroundImageView.image = UIImage(named: layout.topBackgroundImage)
        scrollView.addSubview(topBackgroundImageView)
        
        setUpGuestPassCard()
        
        descriptionLabel.text = layout.descriptionLabelText
        descriptionLabel.font = layout.descriptionLabelFont
        descriptionLabel.textColor = layout.descriptionLabelColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(addFriendsButton)
        scrollView.addSubview(shareReferralButton)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topBackgroundImageView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.right.equalTo(view)
        }
        
        setUpGuestPassCardConstraints()
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(guestPassView.snp.bottom).offset(layout.guestPassViewToDescriptionLabel)
            $0.left.right.equalTo(guestPassView)
        }
        
        addFriendsButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(layout.descriptionLabelToAddFriendsButtom)
            $0.height.equalTo(layout.buttonHeight)
            $0.left.right.equalTo(guestPassView)
        }
        
        shareReferralButton.snp.makeConstraints {
            $0.top.equalTo(addFriendsButton.snp.bottom).offset(layout.addFriendsButtonToShareReferralButton)
            $0.height.equalTo(layout.buttonHeight)
            $0.left.right.equalTo(guestPassView)
        }
    }
    
    private func setUpBindings() {
        addFriendsButton.addTarget(self, action: #selector(displayShareSheet), for: .touchUpInside)
        shareReferralButton.addTarget(self, action: #selector(displayShareSheet), for: .touchUpInside)
        
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

// MARK: - Setup GuestPassView

extension SponsorshipViewController {
    
    private func setUpGuestPassCard() {
        guestPassView.layer.cornerRadius = layout.guestPassCornerRadius
        guestPassView.clipsToBounds = true
        
        guestPassBackgroundImageView.image = UIImage(named: layout.guestPassBackgroundImage)
        guestPassTitleImageView.image = UIImage(named: layout.guestPassTitleImage)
        
        guestPassSealImageView.image = UIImage(named: layout.guestPassSealImage)?.withRenderingMode(.alwaysTemplate)
        guestPassSealImageView.tintColor = .black100.withAlphaComponent(0.25)
        
        guestPassDescriptionLabel.text = layout.guestPassDescriptionText
        guestPassDescriptionLabel.textColor = layout.guestPassDescriptionTextColor
        guestPassDescriptionLabel.font = layout.guestPassDescriptionFont
        
        guestPassView.addSubview(guestPassBackgroundImageView)
        guestPassView.addSubview(guestPassSealImageView)
        guestPassView.addSubview(guestPassTitleImageView)
        guestPassView.addSubview(guestPassDescriptionLabel)
        scrollView.addSubview(guestPassView)
    }
    
    private func setUpGuestPassCardConstraints() {
        guestPassView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(layout.topToGuestPassView)
            $0.left.equalTo(view).offset(layout.horizontalPadding)
            $0.right.equalTo(view).offset(-layout.horizontalPadding)
        }
        
        guestPassBackgroundImageView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
        
        guestPassSealImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        guestPassTitleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(layout.topGuestPassViewToGuestPassTitleImageView)
            $0.centerX.equalToSuperview()
        }
        
        guestPassDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(guestPassTitleImageView.snp.bottom).offset(layout.guestPassTitleImageViewToGuestPassDescriptionLabel)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-layout.guestPassDescriptionLabelToBottomGuestPassView)
        }
    }
}

// MARK: - Convenience Methods

extension SponsorshipViewController {
    
    @objc private func displayShareSheet() {
        let shareContent = layout.shareContentModaltext
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
                    $0.top.equalTo(shareReferralButton.snp.bottom).offset(layout.firstRewardCardTopOffset)
                    $0.left.right.equalTo(guestPassView)
                }
            }
            else {
                let isLastCard = index == rewardCards.count - 1
                let previousCard = rewardCards[index - 1]
                
                if isLastCard {
                    rewardCard.snp.makeConstraints {
                        $0.top.equalTo(previousCard.snp.bottom).offset(layout.spaceBetweenRewardCards)
                        $0.left.right.equalTo(guestPassView)
                        $0.bottom.equalToSuperview().offset(-layout.lastRewardCardBottomOffset)
                    }
                } else {
                    rewardCard.snp.makeConstraints {
                        $0.top.equalTo(previousCard.snp.bottom).offset(layout.spaceBetweenRewardCards)
                        $0.left.right.equalTo(guestPassView)
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
