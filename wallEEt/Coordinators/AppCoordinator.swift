//
//  AppCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//
import UIKit
final class AppCoordinator:Coordinator{
    //some start logic here
    func start(){
        let mainScreenCoordinator = MainScreenCoordinator(navController: navController)
        mainScreenCoordinator.start()
        childCoordinators.append(mainScreenCoordinator)
    }
    deinit {
        print("appCoordinatordeinit")
    }
    
    
}
