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
import Charts


struct MainScreenViewModel{
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    var accountModel:AccountModel?
    
    //MARK: - Inputs
    let showDetails:AnyObserver<Void>
    let addAccountItem:AnyObserver<PieChartData?>
    
    //MARK: - Outputs
    //Call to show details
    let showDetailsScreen:Observable<Void>
    let accItems: Observable<[AccountItem]>
    let pieData:Observable<PieChartData?>
    
    //let pieChartVariable = Variable<PieChartData?>(nil)
    
    
    
    init(){
        let _showDetails =  PublishSubject<Void>()
        self.showDetails = _showDetails.asObserver()
        self.showDetailsScreen = _showDetails.asObservable()
        let _pieData = PublishSubject<PieChartData?>()
        self.pieData = _pieData.asObservable()
        self.addAccountItem = _pieData.asObserver()
        
        let _accItems = Variable<[AccountItem]> ([])
        self.accItems = _accItems.asObservable()
        
       //Get account object
        let account = realm.objects(AccountModel.self).first
        if let accountM = account{
            self.accountModel = accountM
        }else{
            //TODO: - show "Add new account" dialogue
            self.accountModel = AccountModel(name:"TEST")
            
            try! realm.write {
                realm.add(accountModel!)
            }
        }
       //Observe account object
        let accountObservable =  Observable.from(object: accountModel!)
        accountObservable.map { acc -> [AccountItem] in
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
    
    func addExpensesItem(amount:Double,comment:String,date:Date?){
        let item = ExpensesModel(amount: amount, date: date ?? Date(), comment: comment)
        try! realm.write {
            accountModel?.expenses.append(item)
        }
        
        
    }
    func addIncomesItem(amount:Double,source:IncomeSources,date:Date?){
        let item = IncomesModel(amount:amount,date: date ?? Date(), source:source)
        try! realm.write {
            accountModel?.incomes.append(item)
        }
       
    }
    
    func updateChart(){
        guard accountModel!.expenses.count > 0 || accountModel!.incomes.count > 0 else{return}
        let totalExpensesAmount = accountModel?.expenses.reduce(0){sum, expense in
            return sum + expense.amount
        }
        let totalIncomesAmount = accountModel?.incomes.reduce(0){sum, income in
            return sum + income.amount
        }
        let expensesEntry:PieChartDataEntry = PieChartDataEntry(value: Double(totalExpensesAmount!), label: "Expenses")
        let incomeEntry: PieChartDataEntry = PieChartDataEntry(value: Double(totalIncomesAmount!), label: "Incomes")
        let pieChartData = PieChartDataSet(values: [expensesEntry,incomeEntry], label: nil)
        let data = PieChartData(dataSet: pieChartData)
        pieChartData.colors = [UIColor.red,UIColor.green]
        addAccountItem.onNext(data)

    }


   
}


