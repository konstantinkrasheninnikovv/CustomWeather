//
//  SceneDelegate.swift
//  CustomWeather
//
//  Created by Константин Крашенинников on 13.03.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
                
        startAppFlow()
//        self.window = window
    }
}

private extension SceneDelegate {
    
    private func startAppFlow() {
        
        let navController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        appCoordinator.startFlow()
    }
}
