//
//  MainScreenInteractor.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenInteractorProtocol: AnyObject {
    func getCurrentWeatherData(model: WeatherRequestType)
    func getForecastWeatherData(model: WeatherRequestType)
    func getImageForScreen(model: UnsplashRequestType)
}

final class MainScreenInteractor {
    
    // MARK: - External dependencies
    
    private weak var presenter: MainScreenInteractorOutput?
    let network = NetworkManager()
    
    func setUpPresenter(_ presenter: MainScreenInteractorOutput) {
        self.presenter = presenter
    }
}

// MARK: - MainScreenInteractorProtocol

extension MainScreenInteractor: MainScreenInteractorProtocol {

    // - Current and Forecast Weather
    func getCurrentWeatherData(model: WeatherRequestType) {
        makeNetworkWeatherRequest(for: model)
    }
    func getForecastWeatherData(model: WeatherRequestType) {
        makeNetworkWeatherRequest(for: model)
    }
    // Image Unsplash Screen Request
    func getImageForScreen(model: UnsplashRequestType) {
        makeImageNetworkRequest(for: model)
    }
}

private extension MainScreenInteractor {
    
    private func makeNetworkWeatherRequest(for model: WeatherRequestType) {
        let endpoint = chooseWeatherEndpoint(for: model)
        
        Task {
            do {
                let weather: WeatherResponse = try await network.fetch(endpoint: endpoint)
                await MainActor.run {
                    handleSuccessWeatherResponse(weather, for: model)
                }
            } catch {
                
                await MainActor.run {
                    // to do:!
                    //                                presenter?.displayError(error.localizedDescription)
                    print("Parsing error: \(error)")
                }
            }
        }
    }
    
    private func chooseWeatherEndpoint(for model: WeatherRequestType) -> WeatherEndpoint {
        
        switch model {
        case .current(let city, let aqi):
            return .current(city: city, aqi: aqi)
        case .forecast(let city, let days, _, _):
            return .forecast(city: city, days: days)
        }
    }
    
    private func handleSuccessWeatherResponse(_ weather: WeatherResponse, for model: WeatherRequestType) {
        switch model {
        case .current:
            let data = weather.current
            presenter?.didFetchCurrentWeatherData(data)
            presenter?.didFetchEnvironmentalMetricsData(data)
        case .forecast(_, _, let hours, let steps):
            guard let daysData = weather.forecast?.forecastday else { return }
            let currentTime = weather.current.time
            let dataForHoursForecast = filterDataForHourlyRequest(daysData, hours, steps, currentTime)
            presenter?.didFetchHourlyForecastData(dataForHoursForecast)
            presenter?.didFetchDaysForecastData(daysData)
        }
    }
    
    private func filterDataForHourlyRequest(_ days: [ForecastDay], _ hoursAmount: Int, _ steps: Int, _ currentTime: String) -> [Hour] {
        
        Array(
            days.flatMap{ $0.hour }
                .filter { $0.time > currentTime }
                .enumerated().filter { (index, value) in index % steps == 0 }
                .map { $0.element }
                .prefix(hoursAmount))
    }
}

//MARK: - // Image Screen Request

private extension MainScreenInteractor {
    
    private func makeImageNetworkRequest(for model: UnsplashRequestType) {
        let endpoint = chooseUnsplashEndpoint(for: model)
        
        Task {
            do {
                let unsplash: UnsplashResponse = try await network.fetch(endpoint: endpoint)
                await MainActor.run {
                    handleImageSuccessResponse(unsplash)
                }
            } catch {
                // to do:!
                //                                presenter?.displayError(error.localizedDescription)
                print("Parsing error: \(error)")
            }
        }
        
    }
    
    private func chooseUnsplashEndpoint(for model: UnsplashRequestType) -> UnsplashEndpoint {
        switch model {
        case .random(query: let query, orientantion: let orientantion):
                .random(query: query, orientation: orientantion)
        }
    }
    
    private func handleImageSuccessResponse(_ unsplash: UnsplashResponse) {
        print(unsplash.urls.regular)
        presenter?.didFetchImageUnsplash(unsplash.urls)
    }
}
