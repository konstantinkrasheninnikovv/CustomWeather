//
//  MainScreenDaysForecastWeatherModel.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.04.2026.
//

import UIKit

struct MainScreenDaysForecastWeatherModel {
    let date: String
    let iconImageName: String
    let temp: String
    let iconConfig: UIImage.SymbolConfiguration
    let conditionDescription: String?
    let rainChance: String?
}
