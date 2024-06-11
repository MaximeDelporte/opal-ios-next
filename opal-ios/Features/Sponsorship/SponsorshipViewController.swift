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
    private var separatorImageViews = [UIImageView]()
    
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
    
    @objc private func shareButtonTapped() {
        let activityViewController = UIActivityViewController(activityItems: layout.activityItems, applicationActivities: nil)
        self.present(activityViewController, animated: true)
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
        addFriendsButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        shareReferralButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        viewModel.statePublisher.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                break
            case .loaded(let sponsorship):
                let rewards = sponsorship.rewards
                self.createRewardCards(from: rewards)
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

// MARK: - RewardCard

extension SponsorshipViewController {
    
    private func createRewardCards(from rewards: [Reward]) {
        
        for (index, reward) in rewards.enumerated() {
            let completion = viewModel.getCompletion(for: reward)
            let layout = RewardCardLayout(reward: reward, completion: completion)
            let rewardCard = RewardCard(layout: layout)
            rewardCards.append(rewardCard)
            
            let isNotTheLastReward = index != rewards.count - 1
            if isNotTheLastReward  {
                addSeparatorImageView()
            }
        }
        
        setUpRewardCardsConstraints()
    }
    
    private func addSeparatorImageView() {
        let separatorImage = UIImage(systemName: "arrow.down")
        let separatorImageView = UIImageView(image: separatorImage)
        separatorImageView.tintColor = layout.separatorColor
        separatorImageViews.append(separatorImageView)
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
                
                rewardCard.updateLayout()
                continue
            } 
            
            let isLastCard = index == rewardCards.count - 1
            let previousCard = rewardCards[index - 1]
            let currentSeparatorView = separatorImageViews[index - 1]
            scrollView.addSubview(currentSeparatorView)
            
            currentSeparatorView.snp.makeConstraints {
                $0.top.equalTo(previousCard.snp.bottom).offset(layout.separatorVerticalOffset)
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(rewardCard.snp.top).offset(-layout.separatorVerticalOffset)
            }
            
            rewardCard.snp.makeConstraints {
                $0.left.right.equalTo(guestPassView)
            }
            
            if isLastCard {
                rewardCard.snp.removeConstraints()
                rewardCard.snp.makeConstraints {
                    $0.left.right.equalTo(guestPassView)
                    $0.bottom.equalToSuperview().offset(-layout.lastRewardCardBottomOffset)
                }
            }
            
            rewardCard.updateLayout()
        }
    }
}

#Preview {
    SponsorshipViewController()
}
