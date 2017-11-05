//
//  Expenses.swift
//  wallEEt
//
//  Created by ParaBellum on 10/4/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RealmSwift
enum ExpenseCategory:String {
    case food, home, gifts, party, other
}
class ExpensesModel:Object,AccountItem{
    //Properties
    @objc dynamic var amount: Double = 0
    @objc dynamic var date: Date!
    @objc dynamic var comment: String = ""
    @objc dynamic var category:String = "other"
    
    //Init
    convenience init(amount:Double, date: Date,category:ExpenseCategory, comment:String){
        self.init()
        self.amount = amount
        self.date = date
        self.category = category.rawValue
        self.comment = comment
    }
    
}

