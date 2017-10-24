//
//  ExpensesIncomesInfoViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/24/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ExpensesIncomesInfoViewModel {
    private let dict = [1:"Incomes",
                        0:"Expenses"]
    var title:String!
    //Input
    
    let close:AnyObserver<Void>
    //Output
    let didClose:Observable<Void>
//    let labelText:Driver<String>
    let accItems:Driver<[AccountItem]>
    
    init(accountItemsToShow:Int){
        self.title = dict[accountItemsToShow]
        
//        let _labelText = Variable<String>(title)
//        self.labelText = _labelText.asDriver()
        let _accItems = Variable<[AccountItem]>([])
        self.accItems = _accItems.asDriver()
        let _close = PublishSubject<Void>()
        self.close = _close.asObserver()
        self.didClose = _close.asObservable()
 
    }
}
