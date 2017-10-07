//
//  AccountModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/4/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RealmSwift
class AccountModel:Object{
    let expenses = List<ExpensesModel>()
    let incomes = List<IncomesModel>()
}
