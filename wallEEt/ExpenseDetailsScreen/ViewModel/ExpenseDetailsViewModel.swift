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
    func passText(text:String)
}

protocol ExpenseDetailsViewModelCoordinatorDelegate:class {
    func expenseDetailsViewModelDidEnd()
    func expenseDetailsViewModelDidPassText(text:String)
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
    func passText(text: String) {
        coordinatorDelegate?.expenseDetailsViewModelDidPassText(text: text)
    }
    
}
