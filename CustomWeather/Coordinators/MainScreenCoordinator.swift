//
//  MainScreenCoordinator.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    private var viewControllers: [UIViewController] = []
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        let rootVC = MainScreenAssembly.buildModule()
        viewControllers.append(rootVC)
        navigationController?.pushViewController(rootVC, animated: false)
    }
    
}
