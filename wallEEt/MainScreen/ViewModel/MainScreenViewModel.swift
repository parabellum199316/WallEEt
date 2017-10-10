//
//  MainScreenViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm



struct MainScreenViewModel{
    let disposeBag = DisposeBag()
    //MARK: - Properties
    let realm = try! Realm()
    var accountModel:AccountModel?
    
    //MARK: - Inputs
    let showDetails:AnyObserver<Void>
    
    //MARK: - Outputs
    //Call to show details
    let showDetailsScreen:Observable<Void>
    let accItems: Observable<[AccountItem]>
    
    
    private let _accItems = Variable<[AccountItem]> ([])
    
    
    init(){
        let _showDetails =  PublishSubject<Void>()
        self.showDetails = _showDetails.asObserver()
        self.showDetailsScreen = _showDetails.asObservable()
        
        
        self.accItems = _accItems.asObservable()
        //Get account object
        let account = realm.objects(AccountModel.self).first
        if let accountM = account{
            self.accountModel = accountM
        }else{
            //TODO: - show "Add new account" dialogue
            self.accountModel = AccountModel()
            
            try! realm.write {
                realm.add(accountModel!)
            }
        }
       
         Observable.from(object: accountModel!).map { acc -> [AccountItem] in
            var accItems = [AccountItem]()
            for expense in acc.expenses{
                accItems.append(expense as AccountItem)
            }
            for income in acc.incomes{
                accItems.append(income as AccountItem)
            }
            return accItems.sorted(by: { (lhs, rhs) -> Bool in
                lhs.date > rhs.date
            })
        }.bind(to: _accItems).addDisposableTo(disposeBag)
    }
    
    func addExpensesItem(amount:Int,comment:String,date:Date?){
        let item = ExpensesModel(amount: amount, date: date ?? Date(), comment: comment)
        try! realm.write {
            accountModel?.expenses.append(item)
        }
        
    }
    func addIncomesItem(amount:Int,source:IncomeSources,date:Date?){
        let item = IncomesModel(amount:amount,date: date ?? Date(), source:source)
        try! realm.write {
            accountModel?.incomes.append(item)
        }
       
    }


   
}


