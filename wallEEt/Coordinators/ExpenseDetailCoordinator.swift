//
//  ExpenseDetailCoordinator.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
protocol ExpenseDetailCoordinatorDelegate: class
{
    func detailCoordinatorDidFinish(detailCoordinator: ExpenseDetailCoordinator)
}

class ExpenseDetailCoordinator: Coordinator {
    weak var delegate:ExpenseDetailCoordinatorDelegate?
    func start(){
        let storyBoard = UIStoryboard(name: "ExpenseDetails", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "ExpenseDetails") as? ExpenseDetailsViewController{
            vc.viewModel = ExpenseDetailsViewModel()
            vc.viewModel.coordinatorDelegate = self
            navController?.pushViewController(vc, animated: true)
        }
    }
    deinit {
        print("COORDINATOR removed")
    }
}
extension ExpenseDetailCoordinator: ExpenseDetailsViewModelCoordinatorDelegate{
    func expenseDetailsViewModelDidEnd() {
        delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
    }
    
    
}
