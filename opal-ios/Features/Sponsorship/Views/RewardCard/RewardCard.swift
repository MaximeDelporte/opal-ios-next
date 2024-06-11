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
    private let contentView = UIView()
    private let requirementLabel = GradientLabel(gradient: .purple)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var bottomView = UIView()
    
    private let layout: RewardCardLayout
    
    init(layout: RewardCardLayout) {
        self.layout = layout
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("RewardCard - init(coder:) has not been implemented")
    }
}

// MARK: - Common Methods

extension RewardCard {
    
    private func setUpViews() {
        backgroundColor = layout.cardBackgroundColor
        layer.cornerRadius = layout.cardCornerRadius
        layer.borderColor = layout.cardBorderColor
        layer.borderWidth = 1
    
        requirementLabel.text = layout.requirementText
        requirementLabel.font = layout.requirementFont
        requirementLabel.numberOfLines =  0
        
        rewardView.backgroundColor = layout.rewardViewBackgroundColor
        rewardView.layer.cornerRadius = layout.cardCornerRadius
        rewardView.addSubview(rewardImageView)
        rewardImageView.image = UIImage(named: layout.imageUrl)
        rewardImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = layout.titleText
        titleLabel.font = layout.titleFont
        titleLabel.textColor = layout.titleColor
        titleLabel.numberOfLines =  0
        
        descriptionLabel.text = layout.descriptionText
        descriptionLabel.font = layout.descriptionFont
        descriptionLabel.textColor = layout.descriptionColor
        descriptionLabel.numberOfLines =  0
        
        setUpBottomView()
        
        addSubview(rewardView)
        addSubview(contentView)
        contentView.addSubview(requirementLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomView)
    }
    
    private func setUpConstraints() {
        rewardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        requirementLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(requirementLabel.snp.bottom).offset(layout.spaceBetweenRequirementAndTitle)
            $0.left.right.equalTo(requirementLabel)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(layout.spaceBetweenTitleAndDescription)
            $0.left.right.equalTo(requirementLabel)
        }
        
        setUpBottomViewConstraints()
    }
}

// MARK: - Setup BottomView

extension RewardCard {
    
    private func setUpBottomView() {
        switch layout.rewardStatus {
        case .todo, .ongoing:
            let layout = ProgressViewLayout(completionPercentage: 1.0)
            let progressView = ProgressView(layout: layout)
            bottomView = progressView
        case .claim:
            let claimButton = UIButton.tertiary(title: layout.claimButtonText)
            claimButton.update(font: layout.claimButtonFont)
            bottomView = claimButton
        case .claimed:
            let claimedButton = UIButton.custom(
                title: layout.claimedButtonText,
                imageName: layout.claimedButtonImage,
                imagePadding: 4,
                backgroundColor: layout.claimedButtonBackgroundColor,
                foregroundColor: layout.claimedButtonForegroundColor
            )
            claimedButton.update(font: layout.claimButtonFont)
            bottomView = claimedButton
        }
        
        contentView.addSubview(bottomView)
    }
    
    private func setUpBottomViewConstraints() {
        switch layout.rewardStatus {
        case .todo, .ongoing:
            bottomView.snp.makeConstraints {
                $0.left.right.equalTo(requirementLabel)
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(layout.spaceBetweenDescriptionAndProgressView)
                $0.height.equalTo(layout.progressViewHeight)
                $0.bottom.equalToSuperview()
            }
        case .claim, .claimed:
            bottomView.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(layout.spaceBetweenDescriptionAndClaimButton)
                $0.left.equalTo(requirementLabel)
                $0.height.equalTo(layout.buttonHeight)
                $0.width.equalTo(layout.buttonWidth)
                $0.bottom.equalToSuperview()
            }
        }
    }
}

// MARK: - Convenience Methods

extension RewardCard {
    
    func updateLayout() {
        rewardView.snp.removeConstraints()
        contentView.snp.removeConstraints()
        
        if layout.isRewardViewBiggerThanContent {
            rewardView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(layout.spaceBetweenTopAndContent)
                $0.left.equalToSuperview().offset(layout.horizontalPadding)
                $0.size.equalTo(layout.rewardViewSize)
                $0.bottom.equalToSuperview().offset(-layout.spaceBetweenContentAndBottom)
            }
            
            contentView.snp.makeConstraints {
                $0.left.equalTo(rewardView.snp.right).offset(layout.spaceBetweenImageAndContent)
                $0.right.equalToSuperview().offset(-layout.horizontalPadding)
                $0.centerY.equalTo(rewardView)
            }
            
        } else {
            rewardView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(layout.horizontalPadding)
                $0.size.equalTo(layout.rewardViewSize)
                $0.centerY.equalTo(contentView)
            }
            
            contentView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(layout.spaceBetweenTopAndContent)
                $0.left.equalTo(rewardView.snp.right).offset(layout.spaceBetweenImageAndContent)
                $0.right.equalToSuperview().offset(-layout.horizontalPadding)
                $0.bottom.equalToSuperview().offset(-layout.spaceBetweenContentAndBottom)
            }
        }
        
        setNeedsLayout()
        layoutIfNeeded()
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
    
    let layout = RewardCardLayout(reward: reward)
    return RewardCard(layout: layout)
}

