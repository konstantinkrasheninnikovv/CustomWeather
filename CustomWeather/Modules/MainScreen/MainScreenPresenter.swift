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
        let rawHours = [
            (time: "14:00", temp: 22, desc: "Sunny", icon: "sun.max.fill"),
            (time: "15:00", temp: 21, desc: "Cloudy", icon: "cloud.sun.fill")
        ]
        
        let models = rawHours.map { data -> MainScreenHourlyWeatherSectionCellModel in
            
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
        view?.displayHourlyWeather(models)
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

// MARK: - MainScreenViewControllerOutput

extension MainScreenPresenter: MainScreenViewControllerOutput {
    func viewDidLoad() {
        
    }
}
