//
//  VisibilityParameters.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 23.04.2026.
//

import UIKit

enum VisibilityParameters {
    
    static var title: String {
        EnvironmentalMetricType.visibility.title
    }
    
    static var subtitle: String {
        EnvironmentalMetricType.visibility.subTitle ?? ""
    }
    
    static var description: String {
        EnvironmentalMetricType.visibility.descpription
    }
    
    case veryPoor, hazy, good, excellent
    
    init(value: Double) {
        switch value {
        case (0..<1): self = .veryPoor
        case (1..<4): self = .hazy
        case (4..<10): self = .good
        case (10..<50): self = .excellent
        default: self = .excellent
        }
    }
    
    var status: String {
        switch self {
        case .veryPoor: Localizable.VisibilityStatus.veryPoor
        case .hazy: Localizable.VisibilityStatus.hazy
        case .good: Localizable.VisibilityStatus.good
        case .excellent: Localizable.VisibilityStatus.excellent
        }
    }
    
//    var iconName: String {
//        switch self {
//        case .veryPoor: "cloud.fog.fill"
//        case .hazy: "sun.haze.fill"
//        case .good: "eye.fill"
//        case .excellent: "binoculars.fill"
//        }
//    }
    
    var color: UIColor {
        switch self {
        case .veryPoor: return .systemRed
        case .hazy:     return .systemOrange
        case .good:     return .systemGreen
        case .excellent: return .systemBlue
        }
    }
}
