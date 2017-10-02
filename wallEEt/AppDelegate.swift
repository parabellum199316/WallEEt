//
//  AppDelegate.swift
//  wallEEt
//
//  Created by ParaBellum on 8/30/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator:AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let navController = UINavigationController()
        window?.rootViewController = navController
        coordinator = AppCoordinator(navController: navController)
        coordinator.start()
        window?.makeKeyAndVisible()
        return true
    }

}

