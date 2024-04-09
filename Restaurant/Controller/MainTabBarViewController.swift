//
//  MainTabBarViewController.swift
//  Restaurant
//
//  Created by olivier geiger on 30/03/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers                 = [createHomeNC(), createDiscoverNC(), createProfileNC()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - FUNCTIONS
    func createHomeNC() -> UINavigationController {
        let homeVC        = RestaurantViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Accueil", image: UIImage(systemName: "tag.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createDiscoverNC() -> UINavigationController {
        let discoverVC         = DiscoverVC()
        discoverVC.tabBarItem  = UITabBarItem(title: "Découverte", image: UIImage(systemName: "fireworks"), tag: 1)
        
        return UINavigationController(rootViewController: discoverVC)
    }
    
    func createProfileNC() -> UINavigationController {
        let profileVC         = ProfileVC()
        profileVC.tabBarItem  = UITabBarItem(title: "Profil", image: UIImage(systemName: "person.fill"), tag: 2)
        
        return UINavigationController(rootViewController: profileVC)
    }
}
