//
//  MainScreenPresenter.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenInteractorOutput: AnyObject {
    
}

protocol MainScreenViewControllerOutput {
    
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
    
}

// MARK: - MainScreenViewControllerOutput

extension MainScreenPresenter: MainScreenViewControllerOutput {
    
}
