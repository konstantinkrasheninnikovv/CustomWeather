//
//  Seeds.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.04.2026.
//

import UIKit

//MARK: - Seeds for CurrentWeatherView

let rawDataForCurrentWeatherView = [
    (titleWind: "wind", valueWind: "14 Km/h", iconWind: "sun.max.fill", titleHumid: "wind", valueHumid: "14 Km/h", iconHumid: "sun.max.fill", titlePressure: "wind", valuePressure: "14 Km/h", iconPressure: "sun.max.fill", temp: 22, condition: "MOSTLY SUNNY", feelslike: "FEELS LIKE 28°", icon: "sun.max.fill")
]

let modelForCurrentWeatherView = rawDataForCurrentWeatherView.map { data -> CurrentWeatherCellViewModel? in
    
    let wind = WeatherParamForBottomViewModel(
        titleModel: BaseLabelViewModel(text: data.titleWind, font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: Theme.Colors.secondaryText),
        valueModel: BaseLabelViewModel(text: data.valueWind, font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: Theme.Colors.mainText),
        iconNameImageModel: data.iconWind
    )
    
    let humidity = WeatherParamForBottomViewModel(
        titleModel: BaseLabelViewModel(text: data.titleHumid, font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: Theme.Colors.secondaryText),
        valueModel: BaseLabelViewModel(text: data.valueHumid, font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: Theme.Colors.mainText),
        iconNameImageModel: data.iconHumid
    )
    
    let pressure = WeatherParamForBottomViewModel(
        titleModel: BaseLabelViewModel(text: data.titlePressure, font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: Theme.Colors.secondaryText),
        valueModel: BaseLabelViewModel(text: data.valuePressure, font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: Theme.Colors.mainText),
        iconNameImageModel: data.iconPressure
    )
    
    let bottomSection = CurrentWeatherBottomViewModel(
        windModel: wind,
        humidityModel: humidity,
        pressureModel: pressure
    )
    
    return nil
}

//MARK: - Seeds for HourlyForecastWeather

private func fetchMockData() {
    let rawHoursForCollectionView = [
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
        (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill")
    ]
    
    _ = rawHoursForCollectionView.map { data -> MainScreenHourlyWeatherSectionCellModel in
        
        let timeModel = BaseLabelViewModel(
            text: data.time,
            font: UIFont.systemFont(ofSize: 14, weight: .medium),
            textColor: Theme.Colors.secondaryText
        )
        
        let tempModel = BaseLabelViewModel(
            text: "\(data.temp)°",
            font: UIFont.systemFont(ofSize: 20, weight: .bold),
            textColor: Theme.Colors.mainText
        )
        
        let descModel = BaseLabelViewModel(
            text: data.desc,
            font: UIFont.systemFont(ofSize: 12, weight: .regular),
            textColor: Theme.Colors.secondaryText
        )
        return MainScreenHourlyWeatherSectionCellModel(
            timeLabelModel: timeModel,
            tempLabelModel: tempModel,
            descLabelModel: descModel,
            iconName: data.icon
        )
    }
    
//        view?.displayHourlyWeather(modelsForHourlyWeather)
    
}


//MARK: - Seeds for DailyForecastWeather

private func fetchMockDataForDaysForecast() {
    
    let rawDataForDaysForecast = [
        (day: "Today", icon: "sun.max.fill", temps: "29/18", desc: "Sun", rain: ""),
        (day: "Tue", icon: "cloud.sun.fill", temps: "28/19", desc: "Pt. Cl.", rain: ""),
        (day: "Wed", icon: "cloud.rain.fill", temps: "24/17", desc: "Shower", rain: "60%"),
        (day: "Thu", icon: "sun.max.fill", temps: "28/18", desc: "Sun", rain: ""),
        (day: "Fri", icon: "sun.max.fill", temps: "27/19", desc: "Sun", rain: ""),
        (day: "Sat", icon: "sun.max.fill", temps: "26/20", desc: "Sun", rain: ""),
        (day: "Sun", icon: "cloud.heavyrain.fill", temps: "28/16", desc: "Rain", rain: "80%")
    ]
    
    _ = rawDataForDaysForecast.map { data -> MainScreenDaysForecastViewCellModel in
        
        let dayModel = BaseLabelViewModel(
            text: data.day,
            font: UIFont.systemFont(ofSize: 12, weight: .regular),
            textColor: Theme.Colors.mainText
        )
        
        let tempsModel = BaseLabelViewModel(
            text: data.temps,
            font: UIFont.systemFont(ofSize: 16, weight: .bold),
            textColor: Theme.Colors.mainText
        )
        
        let descModel = BaseLabelViewModel(
            text: data.desc,
            font: UIFont.systemFont(ofSize: 12, weight: .regular),
            textColor: Theme.Colors.secondaryText
        )
        
        let rainModel = BaseLabelViewModel(
            text: data.rain,
            font: UIFont.systemFont(ofSize: 12, weight: .regular),
            textColor: Theme.Colors.rainyTint
        )
        
        return MainScreenDaysForecastViewCellModel(
            dayOfWeekLabelModel: dayModel,
            tempRangeLabelModel: tempsModel,
            weatherDescriptionLabelModel: descModel,
            rainPossibilityLabelModel: rainModel,
            iconImageName: data.icon
        )
    }
}

//MARK: - Seeds for EnviromentalMetricsCells

private func fetchMockAirQualityData() {
    _ = GaugeValueModel(
        title: "PM2.5",
        value: "12",
        subtitle: "AQI",
        progress: 0.9,
        color: .systemGreen,
        status: "Good",
        description: "Minimisation",
        iconName: nil
    )
    
    _ = GaugeValueModel(
        title: "",
        value: "",
        subtitle: "Pollen",
        progress: 0.5,
        color: .systemYellow,
        status: "Medium",
        description: "Pollen description",
        iconName: "sun.max.fill"
    )
    
    _ = GaugeValueModel(
        title: "",
        value: "",
        subtitle: "UV",
        progress: 0.8,
        color: .systemPurple,
        status: "High",
        description: "UV Index: High",
        iconName: "sun.max.fill"
    )
    
//        let sectionModel = MainScreenEnvironmentalMetricsModel(
//            aqi: aqiModel,
//            pollen: pollenModel,
//            uv: uvModel
//        )
    
//        view?.displayEnvironmentalMetricsData(sectionModel)
}


private func fetchMockImageForTopLocationView() {
    let imageNameForLocationTopImageView = "image-1"
    let modelImageNameForLocationTopImageView = BaseImageViewModel(imageName: imageNameForLocationTopImageView)
//        view?.displayCurrentLocationImage(modelImageNameForLocationTopImageView)
}
