//
//  MainScreen.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 23.04.2026.
//

import UIKit

struct MainScreenMetricsMapper {
    
    static func mapMetrics(_ weather: CurrentWeather) -> MainScreenEnvironmentalMetricsModel {
        let aqiModel = prepareAQIModel(weather)
        let visibilityModel = prepareVisibilityModel(weather)
        let uvModel = prepareUVModel(weather)
        return MainScreenEnvironmentalMetricsModel(aqiModel, visibilityModel, uvModel)
    }
}
private extension MainScreenMetricsMapper {
    
    static private func prepareAQIModel(_ weather: CurrentWeather) -> MainScreenAQIMetricModel {
        guard let rawValue = weather.airQuality?.pm25 else {
            return MainScreenAQIMetricModel(title: AQIParameters.title, value: "", progress: 0.0, status: "No Data", color: .black, description: "")
        }
        let params = AQIParameters(value: rawValue)
        
        return MainScreenAQIMetricModel(
            title: AQIParameters.title,
            value: "\(rawValue)",
            subtitle: AQIParameters.subtitle,
            progress: rawValue/75,
            status: params.status,
            color: params.color,
            description: AQIParameters.descprition)
        }

    static private func prepareVisibilityModel(_ weather: CurrentWeather) -> MainScreenVisibilityMetricModel {
        let rawValue = weather.visibilityKM
        let params = VisibilityParameters(value: rawValue)
        
        return MainScreenVisibilityMetricModel(
            title: VisibilityParameters.title,
            value: "\(rawValue)",
            subtitle: VisibilityParameters.subtitle,
            progress: rawValue / 10.0,
            status: params.status,
            color: params.color,
            description: VisibilityParameters.description)
    }
    
    static private func prepareUVModel(_ weather: CurrentWeather) -> MainScreenUVMetricModel {
        let rawValue = weather.uv
        let params = UVParameters(value: rawValue)

        return MainScreenUVMetricModel(
            title: UVParameters.title,
            progress: rawValue/11.0,
            status: params.status,
            color: params.color,
            iconName: params.iconName,
            description: UVParameters.description)
    }
}
