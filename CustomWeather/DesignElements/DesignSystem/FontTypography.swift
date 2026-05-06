//
//  FontTypography.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 05.05.2026.
//

import UIKit

enum FontTypography {
    case display           // (48pt)
    case titleLarge        // (22pt)
    case titleMedium       // (18pt)
    case bodyMedium        // (16pt)
    case labelSecondary    // (12pt)
    case labelRain         // (12pt, Blue)
    case labelValue        // (12pt)
    case caption           // (10pt)
    
    var fontSize: CGFloat {
        switch self {
        case .display:      return adaptiveSize(52)
        case .titleLarge:   return adaptiveSize(22)
        case .titleMedium:  return 18
        case .bodyMedium:   return 16
        case .labelSecondary, .labelValue, .labelRain: return 12
        case .caption:      return 10
        }
    }
    
    var fontWeight: UIFont.Weight {
        switch self {
        case .display, .titleLarge, .labelValue: return .bold
        case .bodyMedium, .labelRain: return .medium
        default: return .regular
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .display, .titleLarge, .labelValue, .bodyMedium:
            return Theme.Colors.mainText
        case .titleMedium, .labelSecondary:
            return Theme.Colors.secondaryText
        case .labelRain:
            return Theme.Colors.rainyTint
        case .caption:
            return UIColor.white.withAlphaComponent(0.6)
        }
    }
    
    private func adaptiveSize(_ size: CGFloat) -> CGFloat {
        let activeScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        let screenWidth = activeScene?.screen.bounds.width ?? 375
        let baseWidth: CGFloat = 375
        return size * (screenWidth / baseWidth)
    }
}
