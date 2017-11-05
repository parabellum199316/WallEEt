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
import RxCocoa

struct MainScreenViewModel{
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    var accountModel:AccountModel?
    private   let sequence = Observable<Int>.interval(25,
                                                      scheduler: MainScheduler.instance)
    
    //MARK: - Inputs
    let showInfo:AnyObserver<Int>
    let showDetails:AnyObserver<AccountItem>
    let addAccountItem:AnyObserver<PieChartData?>
   
    
    //MARK: - Outputs
    //Call to show details
    let showInfoScreen:Observable<Int>
    let showDetailsScreen:Observable<AccountItem>
    let accItems: Driver<[AccountItem]>
    let pieData:Driver<PieChartData?>
    
    private let balanceVar = Variable<String>("0")
    var balanceDriver:Driver<String> {
        return balanceVar.asDriver()
    }
    
    var cachedRates:[ExchangeRate]
    
    let currencyRates: Variable<[ExchangeRate]>
    var currencyRatesDriver: Driver<[ExchangeRate]>{
        return currencyRates.asDriver()
    }
    private let USDRUB = PublishSubject<Double>()
    var USDRUBObs:Observable<Double>{
        return USDRUB.asObservable()
    }
    var convertedBalance:Driver<String>
    init(){
        if let propertyList = UserDefaults.standard.object(forKey: "rates") as? [[String:Any]]{
            cachedRates = propertyList.flatMap{ ExchangeRate(dictionary:$0)
            }
        }else{
            cachedRates = []
        }
        currencyRates = Variable<[ExchangeRate]>(cachedRates)
        
        convertedBalance = Observable.combineLatest(currencyRates.asObservable().share(), balanceVar.asObservable()){first, second -> String in
            if first.count > 2{
                let balanceDouble = Double(second)!
                return String(format: "%.1f $", ((balanceDouble / first[2].rate)))}else{
                return "$"
            }
            }.asDriver(onErrorJustReturn: "$")
        
        let _showDetails =  PublishSubject<AccountItem>()
        self.showDetails = _showDetails.asObserver()
        self.showDetailsScreen = _showDetails.asObservable()
        
        let _showInfo = PublishSubject<Int>()
        self.showInfo = _showInfo.asObserver()
        self.showInfoScreen = _showInfo.asObservable()
        
        let _pieData = PublishSubject<PieChartData?>()
        self.pieData = _pieData.asDriver(onErrorJustReturn: nil)
        
        self.addAccountItem = _pieData.asObserver()
        let _accItems = Variable<[AccountItem]> ([])
        self.accItems = _accItems.asDriver()
        
        //Get account object
        let account = realm.objects(AccountModel.self).first
        if let accountM = account{
            self.accountModel = accountM
        }else{
            //TODO: - show "Add new account" dialogue
            self.accountModel = AccountModel(name:"TEST",balance: 1000)
            
            try! realm.write {
                realm.add(accountModel!)
            }
        }
        
        //Observe account object
        let accountObservable =  Observable.from(object: accountModel!).share()
        //Observe [AccountItem]
        accountObservable.map { acc -> [AccountItem] in
            var accItems = [AccountItem]()
            for expense in acc.expenses{
                accItems.append(expense as AccountItem)
            }
            for income in acc.incomes{
                accItems.append(income as AccountItem)
            }
            return accItems.prefix(100).sorted(by: { (lhs, rhs) -> Bool in
                lhs.date > rhs.date
            })
            }.bind(to: _accItems).disposed(by: disposeBag)
        
        //Observe account balance
        accountObservable.map{ acc -> String in
            return String(acc.balance)}
        //getCurrencyRates()
        updateChart()
        
    }
    
    func addExpensesItem(amount:Double,category:ExpenseCategory,comment:String,date:Date?){
        let item = ExpensesModel(amount: amount,date: date ?? Date(), category: category, comment: comment)
        try! realm.write {
            accountModel?.expenses.append(item)
            accountModel?.balance -= amount
        }
    }
    
    func getCurrencyRates(){
        var ratesArr = [ExchangeRate]()
        WebService.shared().getCurrencyExRates { (rates, error) in
            guard (error == nil) else{ return }
            for rate in rates!{
                ratesArr.append(rate)
            }
            self.USDRUB.onNext(ratesArr[0].rate)
            self.currencyRates.value = ratesArr
            let propList = ratesArr.map{$0.propertyListRepresentation}
            print(propList)
            UserDefaults.standard.set(propList, forKey: "rates")
        }
        
    }
    
    func addIncomesItem(amount:Double,source:IncomeSources,date:Date?){
        let item = IncomesModel(amount:amount,date: date ?? Date(), source:source)
        try! realm.write {
            accountModel?.incomes.append(item)
            accountModel?.balance += amount
        }
        
    }
    func deleteItem(item:AccountItem){
        if item is ExpensesModel{
          let index =   accountModel?.expenses.index(of: item as! ExpensesModel)
            try! realm.write {
                accountModel?.expenses.remove(at: index!)
                accountModel?.balance += item.amount
            }
        }else{
            let index  = accountModel?.incomes.index(of: item as! IncomesModel)
            try! realm.write {
                accountModel?.incomes.remove(at: index!)
                accountModel?.balance -= item.amount
            }
        }
        updateChart()
    }
    
    func updateChart(){
        balanceVar.value = String(accountModel!.balance)
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
        pieChartData.sliceSpace = 3
        
        let data = PieChartData(dataSet: pieChartData)
        
        pieChartData.colors = [UIColor.red,UIColor.green]
        addAccountItem.onNext(data)
    }
    
}


