//
//  ExpenseDetailsViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
protocol ExpenseDetailsViewModelType{
    var someString:String{get set}
    var coordinatorDelegate:ExpenseDetailsViewModelCoordinatorDelegate?{get set}
    func close()
}

protocol ExpenseDetailsViewModelCoordinatorDelegate:class {
    func expenseDetailsViewModelDidEnd()
}
class ExpenseDetailsViewModel:ExpenseDetailsViewModelType{
    var someString: String
    weak var coordinatorDelegate: ExpenseDetailsViewModelCoordinatorDelegate?
    init(){
        self.someString = "TEST FROM VIEWMODEL DETAILS"
    }
    func close() {
        coordinatorDelegate?.expenseDetailsViewModelDidEnd()
    }
    
}
