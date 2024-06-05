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
    private let requirementLabel = UILabel(font: .captionSemibold)
    private let titleLabel = UILabel(font: .bodyMedium)
    private let descriptionLabel = UILabel(font: .footnoteSemibold)
    private let claimButton = UIButton()
    private let progressView = UIView()
    
    private let reward: Reward
    
    init(reward: Reward) {
        self.reward = reward
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        claimButton.layer.cornerRadius = claimButton.frame.height / 2
        print("rewardView.frame.maxY: \(rewardView.frame.maxY)")
        print("claimButton.frame.maxY: \(claimButton.frame.maxY)")
    }
    
    private var ongoingMode: Bool {
        reward.status == Reward.Status.ongoing
    }
    
    required init?(coder: NSCoder) {
        fatalError("RewardCard - init(coder:) has not been implemented")
    }
}

// MARK: - Common Methods

extension RewardCard {
    
    private func setUpViews() {
        backgroundColor = UIColor(hex: "#141414")
        layer.cornerRadius = 18
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1
    
        requirementLabel.text = "\(reward.requiredFriends) friend".uppercased()
        requirementLabel.textColor = .purple
        
        titleLabel.text = reward.title
        
        descriptionLabel.text = reward.description
        descriptionLabel.textColor = .white.withAlphaComponent(0.4)
        
        if ongoingMode {
            progressView.backgroundColor = .white.withAlphaComponent(0.1)
            progressView.layer.cornerRadius = progressView.frame.height / 2
            
            addSubview(progressView)
        } else {
            claimButton.setTitle("Claim", for: .normal)
            claimButton.titleLabel?.font = .footnoteRegular
            claimButton.setTitleColor(.black, for: .normal)
            claimButton.backgroundColor = .white
            claimButton.layer.cornerRadius = 16
            
            addSubview(claimButton)
        }
        
        rewardView.backgroundColor = .white.withAlphaComponent(0.1)
        rewardView.layer.cornerRadius = 18
        rewardView.addSubview(rewardImageView)
        rewardImageView.image = UIImage(named: reward.imageUrl)
        rewardImageView.contentMode = .scaleAspectFit
        
        addSubview(rewardView)
        addSubview(requirementLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    private func setUpConstraints() {
        rewardView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rewardImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(8)
            $0.right.bottom.equalToSuperview().offset(-8)
        }
        
        requirementLabel.snp.makeConstraints {
            $0.top.equalTo(rewardView)
            $0.left.equalTo(rewardView.snp.right).offset(32)
            $0.right.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(requirementLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(requirementLabel)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(requirementLabel)
        }
        
        if ongoingMode {
            progressView.snp.makeConstraints {
                $0.left.right.equalTo(requirementLabel)
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
                $0.height.equalTo(6)
                $0.bottom.equalToSuperview().offset(-12)
            }
        } else {
            claimButton.snp.makeConstraints {
                $0.left.equalTo(requirementLabel)
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
                $0.bottom.equalToSuperview().offset(-12)
            }
        }
    }
    
//    func updateLayout() {
//        let labelsHeight = label1.intrinsicContentSize.height + label2.intrinsicContentSize.height + label3.intrinsicContentSize.height
//        let shouldCenterImageVertically = labelsHeight < 100
//        
//        // Adjust vertical alignment based on the total height of labels
//        if shouldCenterImageVertically {
//            // Center Image Vertically
//            NSLayoutConstraint.activate([
//                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//                labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
//            ])
//        } else {
//            // Center Labels Vertically
//            NSLayoutConstraint.activate([
//                labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//                imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
//            ])
//        }
//        
//        // Update layout
//        setNeedsLayout()
//        layoutIfNeeded()
//    }
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
    
    return RewardCard(reward: reward)
}

