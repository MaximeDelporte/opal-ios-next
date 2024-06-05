//
//  RewardCard.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import Foundation
import SnapKit
import UIKit

class RewardCard: UIView {
    
    private let rewardView = UIView()
    private let rewardImageView = UIImageView()
    private let requirementLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let claimButton = UIButton()
    private let progressView = UIView()
    
    private let builder: RewardCardBuilder
    
    init(builder: RewardCardBuilder) {
        self.builder = builder
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        claimButton.layer.cornerRadius = claimButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("RewardCard - init(coder:) has not been implemented")
    }
}

// MARK: - Common Methods

extension RewardCard {
    
    private func setUpViews() {
        backgroundColor = builder.cardBackgroundColor
        layer.cornerRadius = builder.cardCornerRadius
        layer.borderColor = builder.cardBorderColor
        layer.borderWidth = 1
    
        requirementLabel.text = builder.requirementText
        requirementLabel.font = builder.requirementFont
        requirementLabel.textColor = .purple
        
        titleLabel.text = builder.titleText
        titleLabel.font = builder.titleFont
        
        descriptionLabel.text = builder.descriptionText
        descriptionLabel.font = builder.descriptionFont
        descriptionLabel.textColor = builder.descriptionColor
        
        if builder.ongoingMode {
            progressView.backgroundColor = builder.progressViewBackgroundColor
            progressView.layer.cornerRadius = progressView.frame.height / 2
            
            addSubview(progressView)
        } else {
            claimButton.setTitle(builder.claimButtonText, for: .normal)
            claimButton.titleLabel?.font = builder.claimButtonFont
            claimButton.setTitleColor(.black, for: .normal)
            claimButton.backgroundColor = .white
            
            addSubview(claimButton)
        }
        
        rewardView.backgroundColor = builder.rewardViewBackgroundColor
        rewardView.layer.cornerRadius = builder.cardCornerRadius
        rewardView.addSubview(rewardImageView)
        rewardImageView.image = UIImage(named: builder.imageUrl)
        rewardImageView.contentMode = .scaleAspectFit
        
        addSubview(rewardView)
        addSubview(requirementLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    private func setUpConstraints() {
        rewardView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(builder.horizontalPadding)
            $0.size.equalTo(builder.rewardViewSize)
            $0.centerY.equalToSuperview()
        }
        
        rewardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        requirementLabel.snp.makeConstraints {
            $0.top.equalTo(rewardView)
            $0.left.equalTo(rewardView.snp.right).offset(builder.spaceBetweenImageAndContent)
            $0.right.equalToSuperview().offset(-builder.horizontalPadding)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(requirementLabel.snp.bottom).offset(builder.spaceBetweenRequirementAndTitle)
            $0.left.right.equalTo(requirementLabel)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(builder.spaceBetweenTitleAndDescription)
            $0.left.right.equalTo(requirementLabel)
        }
        
        if builder.ongoingMode {
            progressView.snp.makeConstraints {
                $0.left.right.equalTo(requirementLabel)
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(builder.spaceBetweenDescriptionAndProgressView)
                $0.height.equalTo(builder.progressViewHeight)
                $0.bottom.equalToSuperview().offset(-builder.spaceBetweenLastComponentAndBottom)
            }
        } else {
            claimButton.snp.makeConstraints {
                $0.left.equalTo(requirementLabel)
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(builder.spaceBetweenDescriptionAndClaimButton)
                $0.bottom.equalToSuperview().offset(-builder.spaceBetweenLastComponentAndBottom)
            }
        }
    }
}

#Preview {
    let reward = Reward(
        imageUrl: "loyal-gem",
        requiredFriends: 1,
        title: "Loyal Gem",
        description: "Unlock this special milestone",
        excludePremiums: false,
        status: .ongoing
    )
    
    let builder = RewardCardBuilder(reward: reward)
    return RewardCard(builder: builder)
}

