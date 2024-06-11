//
//  GradientLabel.swift
//  opal-ios
//
//  Created by afx on 09/06/2024.
//

import Foundation
import UIKit

class GradientLabel: UILabel {
    
    private let gradient: Gradient
    
    init(gradient: Gradient) {
        self.gradient = gradient
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GradientLabel - init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }
        
        // Create a gradient
        let colors = gradient.colors.map { $0 } as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors,
            locations: nil
        )
        
        guard let gradient = gradient else {
            super.drawText(in: rect)
            return
        }
        
        // Clip text
        context.saveGState()
        context.setTextDrawingMode(.clip)
        super.drawText(in: rect)
        
        // Draw gradient
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        context.restoreGState()
    }
}
