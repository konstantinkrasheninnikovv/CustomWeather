//
//  MainScreenSection.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 30.04.2026.
//

import Foundation

enum MainScreenSection: Int, CaseIterable {
    case userLocation
    case currentWeather
    case hourlyForecast
    case daysForecast
    case radarForecast
    case environmentalMetrics
    
    var headerTitle: String? {
        switch self {
        case .hourlyForecast: return "Forecast for now"
        case .daysForecast: return "3-Day Forecast"
        case .radarForecast: return "Live Precipitation Radar"
        case .environmentalMetrics: return "Air Quality Index and Visibility"
        default: return nil
        }
    }
    
    var cellIdentifier: String {
        switch self {
        case .userLocation: UserLocationViewCell.identifier
        case .currentWeather: CurrentWeatherViewCell.identifier
        case .hourlyForecast: MainScreenHourlyWeatherSectionCell.identifier
        case .daysForecast: MainScreenDaysForecastViewCell.identifier
        case .radarForecast: MainScreenRadarViewCell.identifier
        case .environmentalMetrics: MainScreenEnvironmentalMetricsCell.identifier
        }
    }
}
