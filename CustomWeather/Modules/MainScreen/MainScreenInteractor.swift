//
//  MainScreenInteractor.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import Foundation

protocol MainScreenInteractorProtocol: AnyObject {
    
}

final class MainScreenInteractor {
    
    // MARK: - External dependencies
    
    private weak var presenter: MainScreenInteractorOutput?
    
    func setUpPresenter(_ presenter: MainScreenInteractorOutput) {
        self.presenter = presenter
    }
    
}

// MARK: - MainScreenInteractorProtocol

extension MainScreenInteractor: MainScreenInteractorProtocol {
    
}

// MARK: - Network Request

extension MainScreenInteractor {
    
    func fetchWeather() {
        
        let network = NetworkManager()
        let endpoint = WeatherEndpoint.forecast(city: "Limassol", days: 2)
        
        Task {
            do {
                let weather: WeatherResponse = try await network.fetch(endpoint: endpoint)
                
                await MainActor.run {
                    print("Температура в Лимассоле: \(weather.current.tempC)")
                }
            } catch {
                print("Ошибка парсинга: \(error)")
            }
        }
    }
}

