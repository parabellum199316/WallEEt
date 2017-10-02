//
//  Coordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
class Coordinator{
    var childCoordinators:[Coordinator] = []
    weak var navController:UINavigationController?
    init(navController:UINavigationController?) {
        self.navController = navController
    }
}
