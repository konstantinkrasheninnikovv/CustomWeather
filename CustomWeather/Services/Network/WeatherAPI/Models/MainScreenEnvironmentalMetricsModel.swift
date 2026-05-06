//
//  EnvironmentalMetricsModel.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 22.04.2026.
//

import UIKit

protocol MainScreenMetricProtocol {
    var title: String { get }
    var value: String? { get }
    var subtitle: String? { get }
    var progress: Double { get }
    var status: String { get }
    var color: UIColor { get }
    var iconName: String? { get }
    var description: String { get }
}

struct MainScreenAQIMetricModel: MainScreenMetricProtocol {
    var title: String
    var value: String?
    var subtitle: String?
    var progress: Double
    var status: String
    var color: UIColor
    var iconName: String?
    var description: String
}

struct MainScreenVisibilityMetricModel: MainScreenMetricProtocol {
    var title: String
    var value: String?
    var subtitle: String?
    var progress: Double
    var status: String
    var color: UIColor
    var iconName: String?
    var description: String
}

struct MainScreenUVMetricModel: MainScreenMetricProtocol {
    var title: String
    var value: String?
    var subtitle: String?
    var progress: Double
    var status: String
    var color: UIColor
    var iconName: String?
    var description: String
}

struct MainScreenEnvironmentalMetricsModel {
    let aqiModel: MainScreenAQIMetricModel
    let visibilityModel: MainScreenVisibilityMetricModel
    let uvMetricModel: MainScreenUVMetricModel
}

// MARK: - Custom Initialization

extension MainScreenEnvironmentalMetricsModel {
    init(_ aqiModel: MainScreenAQIMetricModel, _ visibilityModel: MainScreenVisibilityMetricModel, _ uvMetricModel: MainScreenUVMetricModel) {
        self.aqiModel = aqiModel
        self.visibilityModel = visibilityModel
        self.uvMetricModel = uvMetricModel
    }
}
