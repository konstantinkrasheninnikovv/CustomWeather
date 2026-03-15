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
