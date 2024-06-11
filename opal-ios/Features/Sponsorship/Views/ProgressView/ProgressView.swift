//
//  ProgressView.swift
//  opal-ios
//
//  Created by afx on 11/06/2024.
//

import Foundation
import UIKit

class ProgressView: UIView {

    private let gaugeView = UIView()
    
    private let layout: ProgressViewLayout
    
    init(layout: ProgressViewLayout) {
        self.layout = layout
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        applyGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ProgressView - init(coder:) has not been implemented")
    }
}

// MARK: - Common Methods

extension ProgressView {
    
    private func setUpViews() {
        clipsToBounds = true
        backgroundColor = layout.backgroundColor
        addSubview(gaugeView)
    }
    
    private func setUpConstraints() {
        gaugeView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(layout.gaugeWidthRatio)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Convenience Methods

extension ProgressView {
    
    private func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = gaugeView.bounds
        gradient.colors = Gradient.purple.colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gaugeView.layer.insertSublayer(gradient, at: 0)
    }
}
