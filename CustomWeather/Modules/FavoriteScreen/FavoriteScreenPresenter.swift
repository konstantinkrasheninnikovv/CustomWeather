//
//  FavoriteScreenPresenter.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import UIKit

protocol FavoriteScreenInteractorOutput: AnyObject {
    
}

protocol FavoriteScreenViewControllerOutput {
    
}

final class FavoriteScreenPresenter {
    
    // MARK: - External dependencies

    private weak var view: FavoriteScreenViewControllerInput?
    private let interactor: FavoriteScreenInteractorProtocol
    
    // MARK: - Initialization

    init(view: FavoriteScreenViewControllerInput?, interactor: FavoriteScreenInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - FavoriteScreenInteractorOutput

extension FavoriteScreenPresenter: FavoriteScreenInteractorOutput {
    
}

// MARK: - FavoriteScreenViewControllerOutput

extension FavoriteScreenPresenter: FavoriteScreenViewControllerOutput {
    
}
