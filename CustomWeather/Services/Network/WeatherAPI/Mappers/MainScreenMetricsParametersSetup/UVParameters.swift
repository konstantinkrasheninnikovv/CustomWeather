//
//  UVStatus.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 23.04.2026.
//

import UIKit

enum UVParameters {
    
    static var title: String {
        EnvironmentalMetricType.uv.title
    }
    
    static var description: String {
        EnvironmentalMetricType.uv.descpription
    }
    
    case low, moderate, high, veryHigh, extreme
    
    init(value: Double) {
        switch value {
        case 0..<3: self = .low
        case 3..<6: self = .moderate
        case 6..<8: self = .high
        case 8..<11: self = .veryHigh
        default: self = .extreme
        }
    }
    
    var status: String {
        switch self {
        case .low: Localizable.UVStatus.low
        case .moderate: Localizable.UVStatus.moderate
        case .high: Localizable.UVStatus.high
        case .veryHigh: Localizable.UVStatus.veryHigh
        case .extreme: Localizable.UVStatus.extreme
        }
    }
    
    var color: UIColor {
        switch self {
        case .low: .systemGreen
        case .moderate: .systemYellow
        case .high: .systemOrange
        case .veryHigh: .systemRed
        case .extreme: .systemPurple
        }
    }
    
    var iconName: String {
        switch self {
        case .low: "sun.min.fill"
        case .moderate, .high: "sun.max.fill"
        case .veryHigh, .extreme: "sun.max.fill"
        }
    }
}
