//
//  Localizable.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.04.2026.
//

import Foundation

enum Localizable {
    enum MainScreen {
        static let feelsLike = NSLocalizedString("current_weather_feels_like_title", comment: "")
        
        static let wind = NSLocalizedString("current_weather_wind_title", comment: "")
        static let humidity = NSLocalizedString("current_weather_humidity_title", comment: "")
        static let pressure = NSLocalizedString("current_weather_pressure_title", comment: "")
    
        static let aqiTitle = NSLocalizedString("current_weather_aqi_title", comment: "")
        static let visibilityTitle = NSLocalizedString("current_weather_visibility_title", comment: "")
        static let uvTitle = NSLocalizedString("current_weather_uv_title", comment: "")
        
        static let aqiSubtitle = NSLocalizedString("current_weather_aqi_subTitle", comment: "")
        static let visibilitySubtitle = NSLocalizedString("current_weather_visibility_subTitle", comment: "")
        
        static let aqiDescription = NSLocalizedString("current_weather_aqi_description", comment: "")
        static let visibilityDescription = NSLocalizedString("current_weather_visibility_description", comment: "")
        static let uvDescription = NSLocalizedString("current_weather_uv_description", comment: "")
    }
    
    enum AqiStatus {
        static let good = NSLocalizedString("aqi_status_good", comment: "")
        static let moderate = NSLocalizedString("aqi_status_moderate", comment: "")
        static let sensitive = NSLocalizedString("aqi_status_sensitive", comment: "")
        static let unhealthy = NSLocalizedString("aqi_status_unhealthy", comment: "")
    }
    
    enum VisibilityStatus {
        static let veryPoor = NSLocalizedString("visibility_status_very_poor", comment: "")
        static let hazy = NSLocalizedString("visibility_status_hazy", comment: "")
        static let good = NSLocalizedString("visibility_status_good", comment: "")
        static let excellent = NSLocalizedString("visibility_status_excellent", comment: "")
    }
    
    enum UVStatus {
        static let low = NSLocalizedString("uv_status_low", comment: "")
        static let moderate = NSLocalizedString("uv_status_moderate", comment: "")
        static let high = NSLocalizedString("uv_status_high", comment: "")
        static let veryHigh = NSLocalizedString("uv_status_very_high", comment: "")
        static let extreme = NSLocalizedString("uv_status_extreme", comment: "")
    }
}

enum WeatherParamType {
    case wind
    case humidity
    case pressure
    
    var title: String {
        switch self {
        case .wind: return Localizable.MainScreen.wind
        case .humidity: return Localizable.MainScreen.humidity
        case .pressure: return Localizable.MainScreen.pressure
        }
    }
    
    var iconName: String {
        switch self {
        case .wind: return "wind"
        case .humidity: return "humidity"
        case .pressure: return "barometer"
        }
    }
}

enum EnvironmentalMetricType {
    case aqi
    case visibility
    case uv
    
    var title: String {
        switch self {
        case .aqi: Localizable.MainScreen.aqiTitle
        case .visibility: Localizable.MainScreen.visibilityTitle
        case .uv: Localizable.MainScreen.uvTitle
        }
    }
    
    var subTitle: String? {
        switch self {
        case .aqi: Localizable.MainScreen.aqiSubtitle
        case .visibility: Localizable.MainScreen.visibilitySubtitle
        default: nil
        }
    }
    
    var descpription: String {
        switch self {
        case .aqi: Localizable.MainScreen.aqiDescription
        case .uv: Localizable.MainScreen.uvDescription
        case .visibility: Localizable.MainScreen.visibilityDescription
        }
    }
}
