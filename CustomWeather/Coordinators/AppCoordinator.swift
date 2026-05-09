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
    
    // MARK: - Public functions
    
    func startFlow() {
        startTabBarFlow()
    }
    
    // MARK: - Private functions
    
    private func startTabBarFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinator.append(tabBarCoordinator)
        tabBarCoordinator.startFlow()
    }
}
