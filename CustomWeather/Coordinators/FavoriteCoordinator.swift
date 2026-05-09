//
//  FavoriteCoordinator.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import UIKit

final class FavoriteCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        let vc = FavoriteScreenAssembly.buildModule()
        navigationController?.pushViewController(vc, animated: false)
    }
}
