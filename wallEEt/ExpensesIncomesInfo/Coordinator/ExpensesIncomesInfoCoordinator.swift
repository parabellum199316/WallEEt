//
//  ExpensesIncomesInfoCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/24/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class ExpensesIncomesInfoCoordinator:BaseCoordinator<Void>{
    var accItemsIndex:Int!
    private let rootViewController:UINavigationController
    init(rootViewController:UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    
    override func start() -> Observable<Void> {
        let viewController  = ExpensesIncomesInfoViewController.initFromStoryboard(name: "ExpensesIncomes")
        let viewModel = ExpensesIncomesInfoViewModel(accountItemsToShow: accItemsIndex)
        viewController.viewModel = viewModel
        let close = viewModel.didClose
        rootViewController.pushViewController(viewController, animated: true)
        return close.do(onNext:{[weak self] _ in
            self?.rootViewController.popViewController(animated: true)
        }).take(1)
    }
    deinit {
        print("coordDeinit")
    }
}
