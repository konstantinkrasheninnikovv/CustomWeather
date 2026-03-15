//
//  AppCoordinator.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

final class AppCoordinator: Coordinator {
    
        
    // MARK: - Public properties
    
    var navigationController: UINavigationController?
    var childCoordinator: [any Coordinator] = []

    // MARK: - Initialization
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // Public functions
    
    func startFlow() {
        startMainScreenFlow()
    }
    
    // Private functions
    
    private func startMainScreenFlow() {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
        print("AppCoordinator: Coordinator")
        childCoordinator.append(mainScreenCoordinator)
        mainScreenCoordinator.startFlow()
    }
    
}
