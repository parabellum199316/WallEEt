//
//  ExpenseDetailsCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/7/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift

class ExpenseDetailsCoordinator: BaseCoordinator<Void>{
    private let rootViewController: UINavigationController
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    override func start() -> Observable<Void> {
        let viewController = ExpenseDetailsViewController.initFromStoryboard(name: "ExpenseDetails")
        let viewModel = ExpenseDetailsViewModel()
        viewController.viewModel = viewModel
        let cancel = viewModel.didCancel
        rootViewController.pushViewController(viewController, animated: true)
        
        return  cancel.do(onNext: { [weak self] _ in self?.rootViewController.popViewController(animated: true)}).take(1)
        
    }
    deinit {
        print("coordDeinit")
    }
}
