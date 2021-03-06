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
    @objc dynamic var amount:Double = 0
    @objc dynamic var date:Date!
    @objc dynamic var source:String = ""
    //Init
    convenience init(amount:Double,date:Date,source:IncomeSources){
        self.init()
        self.amount = amount
        self.date = date
        self.source = source.rawValue
    }
    
}
