//
//  IncomesModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/4/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RealmSwift
enum IncomeSources:String{
    case salary,bonuses,scholarship
}
class IncomesModel:Object,AccountItem{
    //Properties
    dynamic var amount:Int = 0
    dynamic var date:Date!
    dynamic var source:String = ""
    //Init
    convenience init(amount:Int,date:Date,source:IncomeSources){
        self.init()
        self.amount = amount
        self.date = date
        self.source = source.rawValue
    }
    
}
