//
//  FavoriteScreenInteractor.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import Foundation

protocol FavoriteScreenInteractorProtocol {
    
}

final class FavoriteScreenInteractor {
    
    // MARK: - External dependencies
    
    private weak var presenter: FavoriteScreenInteractorOutput?
    
    func setUpPresenter(_ presenter: FavoriteScreenInteractorOutput) {
        self.presenter = presenter
    }
}

extension FavoriteScreenInteractor: FavoriteScreenInteractorProtocol {
    
    
    
}
