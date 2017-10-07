//
//  AppCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/7/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let mainScreenCoordinator = MainScreenCoordinator(window: window)
        return coordinate(to: mainScreenCoordinator)
    }
}
