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
    
    func heightForWidth(_ width: CGFloat) -> CGFloat {
        guard let text = self.text else {
            return 0
        }
        
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(
            with: constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [
                NSAttributedString.Key.font: self.font ?? .systemFont(ofSize: 12)
            ],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
    
    func numberOfLines(_ lines: Int) -> UILabel {
        self.numberOfLines = lines
        return self
    }
}
