//
//  MainScreenCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/7/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift


class MainScreenCoordinator:BaseCoordinator<Void>{
    private let window:UIWindow
    init(window:UIWindow) {
        self.window = window
    }
    override func start() -> Observable<Void> {
        let vm = MainScreenViewModel(testText: "TestTestTest")
        let viewController = MainScreenViewController.initFromStoryboard(name: "Main")
        let navController = UINavigationController(rootViewController: viewController)
        viewController.viewModel = vm
//        vm.showDetailsScreen.flatMap{[weak self] _ -> Observable<Void> in
//            guard let `self` = self else { return .empty() }
//            return self.showDetailScreen(on: viewController)
//            }.bind(to: vm.showDetails).disposed(by: disposeBag)
        vm.showDetailsScreen.flatMap { [weak self] _ -> Observable<Void> in
            guard let `self` = self else { return  .empty() }
            return self.showDetailScreen(on: navController)
            }.subscribe().disposed(by: disposeBag)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        return Observable.never()
    }
    
    private func showDetailScreen(on viewController: UINavigationController) -> Observable<Void>{
        let exDetailsCoordinator = ExpenseDetailsCoordinator(rootViewController: viewController)
        return coordinate(to: exDetailsCoordinator)
        
        }
    deinit {
        print("deinit ")
    }
    
}
