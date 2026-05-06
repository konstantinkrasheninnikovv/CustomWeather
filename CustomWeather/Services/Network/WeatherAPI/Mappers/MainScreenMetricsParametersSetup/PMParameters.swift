//
//  PMParameters.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 23.04.2026.
//

import UIKit

enum AQIParameters {
    
    static var title: String {
        EnvironmentalMetricType.aqi.title
    }
    
    static var subtitle: String {
        EnvironmentalMetricType.aqi.subTitle ?? ""
    }
    
    static var descprition: String {
        EnvironmentalMetricType.aqi.descpription
    }
    
    case good, moderate, sensitive, unhealthy
    
    init(value: Double) {
        switch value {
        case (0..<12): self = .good
        case (12..<35): self = .moderate
        case (35..<55): self = .sensitive
        case (55..<75): self = .unhealthy
        default: self = .unhealthy
        }
    }
    
    var status: String {
        switch self {
        case .good: Localizable.AqiStatus.good
        case .moderate: Localizable.AqiStatus.moderate
        case .sensitive: Localizable.AqiStatus.sensitive
        case .unhealthy: Localizable.AqiStatus.unhealthy
        }
    }
    
    var color: UIColor {
        switch self {
        case .good: .systemGreen
        case .moderate: .systemYellow
        case .sensitive: .systemOrange
        case .unhealthy: .systemRed
        }
    }
}
