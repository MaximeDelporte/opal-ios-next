//
//  Gradient.swift
//  opal-ios
//
//  Created by afx on 11/06/2024.
//

import Foundation
import UIKit

enum Gradient {
    case purple
    
    var colors: [CGColor] {
        switch self {
        case .purple:
            return [
                UIColor.purple100.cgColor,
                UIColor.blue100.cgColor,
                UIColor.blue100.cgColor,
                UIColor.blue100.cgColor
            ]
        }
    }
}
