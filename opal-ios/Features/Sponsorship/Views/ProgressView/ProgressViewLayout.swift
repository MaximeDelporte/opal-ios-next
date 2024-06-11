//
//  ProgressViewLayout.swift
//  opal-ios
//
//  Created by afx on 11/06/2024.
//

import Foundation
import UIKit

class ProgressViewLayout {
    
    let backgroundColor: UIColor
    let gaugeWidthRatio: CGFloat
    
    init(completionPercentage: CGFloat) {
        backgroundColor = .white10
        gaugeWidthRatio = completionPercentage
    }
}
