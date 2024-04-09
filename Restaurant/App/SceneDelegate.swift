//
//  SceneDelegate.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let walkthroughController = WalkthroughController()
        let navigationController = UINavigationController(rootViewController: walkthroughController)
        
        if !UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            window?.rootViewController = navigationController
        } else {
            let mainViewController = MainTabBarViewController()
            window?.rootViewController = UINavigationController(rootViewController: mainViewController)
        }
        
        
        window?.makeKeyAndVisible()
    }
}
