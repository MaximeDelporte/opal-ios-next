//
//  UIButton+Extensions.swift
//  opal-ios
//
//  Created by afx on 07/06/2024.
//

import Foundation
import UIKit

extension UIButton {
    
    enum `Type` {
        case primary
        case secondary
        case tertiary
        case link
    }
    
    static func primary(title: String, imageName: String? = nil) -> UIButton {
        return getDefaultButton(with: title, and: imageName)
            .backgroundColor(.blue100)
            .foregroundColor(.white100)
    }
    
    static func secondary(title: String, imageName: String? = nil) -> UIButton {
        return getDefaultButton(with: title, and: imageName)
            .backgroundColor(.black100)
            .foregroundColor(.white100)
    }
    
    static func tertiary(title: String, imageName: String? = nil) -> UIButton {
        return getDefaultButton(with: title, and: imageName)
            .backgroundColor(.white100)
            .foregroundColor(.black100)
    }
}

// MARK: - Convenience Methods

extension UIButton {
    
    private static func getDefaultButton(with title: String, and imageName: String? = nil) -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.cornerStyle = .capsule
        
        if let imageName {
            configuration.image = UIImage(systemName: imageName)
            configuration.imagePadding = 8
            configuration.imagePlacement = .leading
        }
        
        let button = UIButton(configuration: configuration)
        button.titleLabel?.text = title
        button.titleLabel?.font = .bodyMedium
        return button
    }
    
    private func backgroundColor(_ color: UIColor) -> UIButton {
        guard var background = self.configuration?.background else {
            return self
        }
        background.backgroundColor = color
        self.configuration?.background = background
        return self
    }
    
    private func foregroundColor(_ color: UIColor) -> UIButton {
        self.configuration?.baseForegroundColor = color
        return self
    }
}
