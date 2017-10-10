//
//  MainScreenTableViewCellViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/8/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
enum AccItemType{
    case income
    case expense
}
struct MainScreenTableViewCellViewModel {
    var amount:String
    var stringDate:String
    var accItemType:AccItemType
    
    init(accItem:AccountItem){
        if accItem is ExpensesModel{
            accItemType = .expense
        }else{
            accItemType = .income
        }
        self.amount = String(accItem.amount)
        let date = accItem.date
        stringDate = date!.description(with: Locale.current)
    }
}
