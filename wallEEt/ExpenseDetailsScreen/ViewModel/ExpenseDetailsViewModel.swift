//
//  ExpenseDetailsViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
protocol ExpenseDetailsViewModelType{
    var coordinatorDelegate:ExpenseDetailsViewModelCoordinatorDelegate?{get set}
    func close()
}

protocol ExpenseDetailsViewModelCoordinatorDelegate:class {
    func expenseDetailsViewModelDidEnd()
}
class ExpenseDetailsViewModel:ExpenseDetailsViewModelType{
    weak var coordinatorDelegate: ExpenseDetailsViewModelCoordinatorDelegate?
    init(){
        
    }
    func close() {
        coordinatorDelegate?.expenseDetailsViewModelDidEnd()
    }
    
    
}
