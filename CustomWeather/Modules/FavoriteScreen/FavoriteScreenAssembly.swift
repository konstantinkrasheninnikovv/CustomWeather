//
//  FavoriteScreenAssembly.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import UIKit

final class FavoriteScreenAssembly {
    
    static func buildModule() -> UIViewController {
        let viewManager = FavoriteScreenViewManager()
        let viewController = FavoriteScreenViewController(viewManager: viewManager)
        let interactor = FavoriteScreenInteractor()
        let presenter = FavoriteScreenPresenter(view: viewController, interactor: interactor)
        viewController.setUpPresenter(presenter)
        interactor.setUpPresenter(presenter)
        return viewController
    }
}
