//
//  MainScreenTableViewCellViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/8/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation

struct MainScreenTableViewCellViewModel {
    var amount:Int
    var stringDate:String
    
    init(accItem:AccountItem){
        self.amount = accItem.amount
        let date = accItem.date
        stringDate = date!.description(with: Locale.current)
    }
}
