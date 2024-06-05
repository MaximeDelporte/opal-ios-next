//
//  UILabel+Extensions.swift
//  opal-ios
//
//  Created by afx on 05/06/2024.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(font: UIFont) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = .white
        self.numberOfLines = 0
    }
}
