//
//  TabBarCoordinator.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 07.05.2026.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [any Coordinator] = []
    private let tabBarController = UITabBarController()
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        let mainScreenNavigation = UINavigationController()
        let favoriteNavigation = UINavigationController()
        let weatherMapNavigation = UINavigationController()
//        let pastWeatherNavigation = UINavigationController()
        
        mainScreenNavigation.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun"), tag: 0)
        favoriteNavigation.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "cloud.sun"), tag: 1)
        weatherMapNavigation.tabBarItem = UITabBarItem(title: "WeatherMap", image: UIImage(systemName: "cloud.sun"), tag: 2)
//        pastWeatherNavigation.tabBarItem = UITabBarItem(title: "Past", image: UIImage(systemName: "cloud.sun"), tag: 3)
        
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: mainScreenNavigation)
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavigation)
        
        childCoordinators.append(mainScreenCoordinator)
        childCoordinators.append(favoriteCoordinator)
        
        mainScreenCoordinator.startFlow()
        favoriteCoordinator.startFlow()
        
        tabBarController.viewControllers = [mainScreenNavigation, favoriteNavigation, weatherMapNavigation]
        
        navigationController?.setViewControllers([tabBarController], animated: false)
        navigationController?.isNavigationBarHidden = true
    }
}
