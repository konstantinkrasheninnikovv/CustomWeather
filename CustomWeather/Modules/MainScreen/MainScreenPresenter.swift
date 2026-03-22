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

private extension MainScreenPresenter {
    
    private func fetchMockData() {
        let rawHoursForCollectionView = [
            (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
            (time: "15:00", temp: 21, desc: "Cloudy", icon: "cloud.sun.fill")
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
        
        let modelForCurrentWeatherView = rawDataForCurrentWeatherView.map { data -> CurrentWeatherViewModel in
            
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
                    tempModel: BaseLabelViewModel(text: "\(data.temp)°", font: .systemFont(ofSize: 72, weight: .bold), textColor: Theme.Colors.mainText),
                    conditionModel: BaseLabelViewModel(text: data.condition, font: .systemFont(ofSize: 16, weight: .medium), textColor: Theme.Colors.mainText),
                    feelsLikeModel: BaseLabelViewModel(text: data.feelslike, font: Theme.Fonts.description, textColor: Theme.Colors.secondaryText),
                    mainIconImageModel: data.icon
                )
                
                return CurrentWeatherViewModel(topModel: topSection, bottomModel: bottomSection)
            
        }
        view?.displayHourlyWeather(modelsForHourlyWeather)
        
        if let model = modelForCurrentWeatherView.first {
            view?.displayCurrentWeather(model)
        }
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

// MARK: - MainScreenViewControllerOutput

extension MainScreenPresenter: MainScreenViewControllerOutput {
    func viewDidLoad() {
        fetchMockData()
    }
}
