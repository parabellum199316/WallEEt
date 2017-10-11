//
//  Expenses.swift
//  wallEEt
//
//  Created by ParaBellum on 10/4/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RealmSwift
class ExpensesModel:Object,AccountItem{
    //Properties
    dynamic var amount: Double = 0
    dynamic var date: Date!
    dynamic var comment: String = ""
    //Init
    convenience init(amount:Double, date: Date, comment:String){
        self.init()
        self.amount = amount
        self.date = date
        self.comment = comment
    }
    
}

