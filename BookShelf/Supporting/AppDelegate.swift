//
//  AppDelegate.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let categoryVC = CategoryVC()
        categoryVC.tabBarItem = UITabBarItem(title: "Best Seller", image: UIImage(named: "tab_book_empty"), selectedImage: UIImage(named: "tab_book_filled"))
        let categoryVCNav = UINavigationController(rootViewController: categoryVC)

        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "tab_fav_empty"), selectedImage: UIImage(named: "tab_fav_filled"))
        let favoriteVCNav = UINavigationController(rootViewController: favoriteVC)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [categoryVCNav, favoriteVCNav]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        
        return true
    }

}

