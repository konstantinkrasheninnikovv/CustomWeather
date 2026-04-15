//
//  MainScreenPresenter.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

//MARK: - Commands from Interactor

protocol MainScreenInteractorOutput: AnyObject {
}

//MARK: - Commands from VC

protocol MainScreenViewControllerOutput {
    func viewDidLoad()
}

final class MainScreenPresenter {
    
    // MARK: - External dependencies
    
    private weak var view: MainScreenViewControllerInput?
    private let interactor: MainScreenInteractorProtocol
    
    // MARK: - Initialization

    init(view: MainScreenViewControllerInput?, interactor: MainScreenInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - MainScreenViewControllerInput

private extension MainScreenPresenter {
    
    private func fetchMockImageForTopLocationView() {
        
        let imageNameForLocationTopImageView = "image-1"
        let modelImageNameForLocationTopImageView = BaseImageViewModel(imageName: imageNameForLocationTopImageView)
        view?.displayCurrentLocationImage(modelImageNameForLocationTopImageView)
    }
    
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
        
        let modelsForHourlyWeather = rawHoursForCollectionView.map { data -> MainScreenHourlyWeatherSectionCellModel in
            
            let timeModel = BaseLabelViewModel(
                text: data.time,
                font: Theme.Fonts.time,
                textColor: Theme.Colors.secondaryText
            )
            
            let tempModel = BaseLabelViewModel(
                text: "\(data.temp)°",
                font: Theme.Fonts.temperature,
                textColor: Theme.Colors.mainText
            )
            
            let descModel = BaseLabelViewModel(
                text: data.desc,
                font: Theme.Fonts.description,
                textColor: Theme.Colors.secondaryText
            )
            return MainScreenHourlyWeatherSectionCellModel(
                timeLabelModel: timeModel,
                tempLabelModel: tempModel,
                descLabelModel: descModel,
                iconName: data.icon
            )
        }
        
        let rawDataForCurrentWeatherView = [
            (titleWind: "wind", valueWind: "14 Km/h", iconWind: "sun.max.fill", titleHumid: "wind", valueHumid: "14 Km/h", iconHumid: "sun.max.fill", titlePressure: "wind", valuePressure: "14 Km/h", iconPressure: "sun.max.fill", temp: 22, condition: "MOSTLY SUNNY", feelslike: "FEELS LIKE 28°", icon: "sun.max.fill")
        ]
        
        let modelForCurrentWeatherView = rawDataForCurrentWeatherView.map { data -> CurrentWeatherCellViewModel in
            
            let wind = WeatherParamForBottomViewModel(
                titleModel: BaseLabelViewModel(text: data.titleWind, font: Theme.Fonts.description, textColor: Theme.Colors.secondaryText),
                valueModel: BaseLabelViewModel(text: data.valueWind, font: Theme.Fonts.temperature, textColor: Theme.Colors.mainText),
                iconNameImageModel: data.iconWind
            )
            
            let humidity = WeatherParamForBottomViewModel(
                titleModel: BaseLabelViewModel(text: data.titleHumid, font: Theme.Fonts.description, textColor: Theme.Colors.secondaryText),
                valueModel: BaseLabelViewModel(text: data.valueHumid, font: Theme.Fonts.temperature, textColor: Theme.Colors.mainText),
                iconNameImageModel: data.iconHumid
            )
            
            let pressure = WeatherParamForBottomViewModel(
                titleModel: BaseLabelViewModel(text: data.titlePressure, font: Theme.Fonts.description, textColor: Theme.Colors.secondaryText),
                valueModel: BaseLabelViewModel(text: data.valuePressure, font: Theme.Fonts.temperature, textColor: Theme.Colors.mainText),
                iconNameImageModel: data.iconPressure
            )
            
            let bottomSection = CurrentWeatherBottomViewModel(
                windModel: wind,
                humidityModel: humidity,
                pressureModel: pressure
            )
            
            let topSection = CurrentWeatherTopViewModel(
                tempModel: BaseLabelViewModel(text: "\(data.temp)°С", font: .systemFont(ofSize: 64, weight: .bold), textColor: Theme.Colors.mainText),
                conditionModel: BaseLabelViewModel(text: data.condition, font: .systemFont(ofSize: 22, weight: .medium), textColor: Theme.Colors.mainText),
                feelsLikeModel: BaseLabelViewModel(text: data.feelslike, font: Theme.Fonts.feelsLikeLabelFont, textColor: Theme.Colors.secondaryText),
                mainIconImageModel: data.icon
            )
            
            return CurrentWeatherCellViewModel(topModel: topSection, bottomModel: bottomSection)
        }
        
        view?.displayHourlyWeather(modelsForHourlyWeather)
        
        if let model = modelForCurrentWeatherView.first {
            view?.displayCurrentWeather(model)
        }
    }
    
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
        
        let modelForDaysForecastWeather = rawDataForDaysForecast.map { data -> MainScreenDaysForecastViewCellModel in
            
            let dayModel = BaseLabelViewModel(
                text: data.day,
                font: Theme.Fonts.description,
                textColor: Theme.Colors.mainText
            )
            
            let tempsModel = BaseLabelViewModel(
                text: data.temps,
                font: Theme.Fonts.fontForTemperature,
                textColor: Theme.Colors.mainText
            )
            
            let descModel = BaseLabelViewModel(
                text: data.desc,
                font: Theme.Fonts.description,
                textColor: Theme.Colors.secondaryText
            )
            
            let rainModel = BaseLabelViewModel(
                text: data.rain,
                font: Theme.Fonts.description,
                textColor: .systemBlue
            )
            return MainScreenDaysForecastViewCellModel(
                dayOfWeekLabelModel: dayModel,
                tempRangeLabelModel: tempsModel,
                weatherDescriptionLabelModel: descModel,
                rainPossibilityLabelModel: rainModel,
                iconImageName: data.icon
            )
        }
        view?.displayDaysForecastWeather(modelForDaysForecastWeather)
    }
    
    private func fetchMockAirQualityData() {
        let aqiModel = GaugeValueModel(
            title: "PM2.5",
            value: "12",
            subtitle: "AQI",
            progress: 0.3,
            color: .systemGreen,
            status: "Good",
            description: "Minimisation",
            iconName: nil
        )
        
        let pollenModel = GaugeValueModel(
            title: "",
            value: "",
            subtitle: "Pollen",
            progress: 0.5,
            color: .systemYellow,
            status: "Medium",
            description: "Pollen description",
            iconName: "sun.max.fill"
        )
        
        let uvModel = GaugeValueModel(
            title: "",
            value: "",
            subtitle: "UV",
            progress: 0.8,
            color: .systemPurple,
            status: "High",
            description: "UV Index: High",
            iconName: "sun.max.fill"
        )
        
        let sectionModel = AirQualitySectionCellModel(
            aqi: aqiModel,
            pollen: pollenModel,
            uv: uvModel
        )
        
        view?.displayAirAndQualityData(sectionModel)
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

// MARK: - MainScreenViewControllerOutput

extension MainScreenPresenter: MainScreenViewControllerOutput {
    func viewDidLoad() {
        fetchMockData()
        fetchMockImageForTopLocationView()
        fetchMockDataForDaysForecast()
        fetchMockAirQualityData()
    }
}
