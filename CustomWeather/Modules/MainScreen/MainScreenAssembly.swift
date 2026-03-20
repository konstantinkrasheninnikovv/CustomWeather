//
//  MainScreenAssembly.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

final class MainScreenAssembly {
    
    static func buildModule() -> UIViewController {
        
        let viewManager = MainScreenViewManager()
        let viewController = MainScreenViewController(viewManager: viewManager)
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter(view: viewController, interactor: interactor)
        viewController.setUpPresenter(presenter)
        interactor.setUpPresenter(presenter)
        return viewController
        
    }
}
