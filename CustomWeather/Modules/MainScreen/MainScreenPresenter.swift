//
//  MainScreenPresenter.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

enum WeatherRequestType {
    case current(city: String, aqi: String)
    case forecast(city: String, days: Int, hours: Int, step: Int)
}

enum UnsplashRequestType {
    case random(query: String, orientantion: String)
}

//MARK: - Commands from Interactor

protocol MainScreenInteractorOutput: AnyObject {
    func didFetchCurrentWeatherData(_ data: CurrentWeather)
    func didFetchHourlyForecastData(_ data: [Hour])
    func didFetchDaysForecastData(_ data: [ForecastDay])
    func didFetchEnvironmentalMetricsData(_ data: CurrentWeather)
    func didFetchImageUnsplash(_ data: URLs)
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

// MARK: - MainScreenInteractorOutput

extension MainScreenPresenter: MainScreenInteractorOutput {
    
    func didFetchCurrentWeatherData(_ data: CurrentWeather) {
        let currentWeatherModel = MainScreenMapper.mapCurrentWeather(data)
        view?.displayCurrentWeather(using: currentWeatherModel)
    }
    
    func didFetchHourlyForecastData(_ data: [Hour]) {
        let hourlyForecastWeatherModel = MainScreenMapper.mapHourlyData(data)
        view?.displayHourlyWeather(hourlyForecastWeatherModel)
    }
    
    func didFetchDaysForecastData(_ data: [ForecastDay]) {
        let daysForecastWeatherModel = MainScreenMapper.mapDaysData(data)
        view?.displayDaysForecastWeather(daysForecastWeatherModel)
    }
    
    func didFetchEnvironmentalMetricsData(_ data: CurrentWeather) {
        let environmentalMetricsModel = MainScreenMetricsMapper.mapMetrics(data)
        view?.displayEnvironmentalMetricsData(environmentalMetricsModel)
    }
    
    func didFetchImageUnsplash(_ data: URLs) {
        let modelForImageLocation = MainScreenLocationImageMapper.mapDataImage(data)
        view?.displayCurrentLocationImage(modelForImageLocation)
    }
}

// MARK: - MainScreenViewControllerOutput

extension MainScreenPresenter: MainScreenViewControllerOutput {
    func viewDidLoad() {
        
        let requestForCurrentWeather: WeatherRequestType = .current(city: "Limassol", aqi: "yes")
        let requestForForecastWeather: WeatherRequestType = .forecast(city: "Limassol", days: 3, hours: 9, step: 2)
        let requestForImageScreenUnsplash: UnsplashRequestType = .random(query: "NN, city, rain", orientantion: "portrait")
        
        interactor.getCurrentWeatherData(model: requestForCurrentWeather)
        interactor.getForecastWeatherData(model: requestForForecastWeather)
        interactor.getImageForScreen(model: requestForImageScreenUnsplash)
        }
}
