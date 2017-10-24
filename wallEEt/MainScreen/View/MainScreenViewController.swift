//
//  ViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 8/30/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import RxCocoa
enum AlertType{
    case income
    case expense
}
class MainScreenViewController: UIViewController,StoryboardInitializable {
    var viewModel:MainScreenViewModel!
    private var expanded:Bool = false
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var currencyRate: UILabel!
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var balanceInUSD: UILabel!
    @IBOutlet weak var addExpense: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var toDetailsButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var tableTopToButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableToLayoutGuideConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonToPieChartViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonToTopLayoutGuideConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.legend.enabled = false
        pieChartView.chartDescription?.enabled = false
        pieChartView.transparentCircleColor = UIColor.black.withAlphaComponent(0.2)
        pieChartView.transparentCircleRadiusPercent = 0.6
        pieChartView.holeRadiusPercent = 0.55
        pieChartView.holeColor = UIColor.red.withAlphaComponent(0)
        pieChartView.delegate = self
        tableTopToButtonConstraint.isActive = true
        tableToLayoutGuideConstraint.isActive = false
        buttonToTopLayoutGuideConstraint.isActive = false
        buttonToPieChartViewConstraint.isActive = true
        bind()
    }
    
    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        showAlert(type: .expense)
        
    }
    
    
    
    @IBAction func expandTable(_ sender: Any) {
        animate(isExpanded: expanded)
        
        
    }
    @IBAction func addIncomeButtonTapped(_ sender: Any) {
        showAlert(type: .income)
    }
    private func bind(){
        //toDetailsButton.rx.tap.bind(to:viewModel.showDetails).disposed(by: disposeBag)
        tableView.rx.modelSelected(AccountItem.self).subscribe(onNext:{item in
            self.viewModel.showDetails.onNext(item)
            if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
            }
        }).addDisposableTo(disposeBag)
        
        tableView.rx.modelDeleted(AccountItem.self).subscribe(onNext:{ item in
            self.viewModel.deleteItem(item: item)
        }).addDisposableTo(disposeBag)
        
        viewModel.accItems.drive(tableView.rx.items(cellIdentifier: "AccItemCell", cellType: MainScreenTableViewCell.self)){
            row, item, cell in
            let cellVM = MainScreenTableViewCellViewModel(accItem: item)
            cell.viewModel = cellVM
            cell.configure()
            }.addDisposableTo(disposeBag)
        
        viewModel.pieData
            .drive(onNext: { (data) in
                self.pieChartView.data = data
                self.pieChartView.notifyDataSetChanged()
                self.pieChartView.setNeedsDisplay()
            }).addDisposableTo(disposeBag)
        
        viewModel.balanceDriver.drive(onNext:{string in
            self.currentBalance.text = string
        }).addDisposableTo(disposeBag)
        
        //TODO: - Consider logic
        
        viewModel.currencyRatesDriver.drive(onNext:{rates in
            guard rates.count > 2 else{return}
            self.currencyRate.text = rates[2].name + " \(rates[2].rate)"
        }).addDisposableTo(disposeBag)
        
        viewModel.convertedBalance.drive(onNext:{balanceInUSD in
            self.balanceInUSD.text = balanceInUSD
        }).addDisposableTo(disposeBag)
        
        viewModel.updateChart()
    }
    
    fileprivate func animate(isExpanded:Bool) {
        tableToLayoutGuideConstraint.isActive = !isExpanded
        tableTopToButtonConstraint.isActive = isExpanded
        buttonToTopLayoutGuideConstraint.isActive = !isExpanded
        buttonToPieChartViewConstraint.isActive = isExpanded
        self.expanded = !isExpanded
        
        UIView.animate(withDuration: 0.4) {
            self.view.needsUpdateConstraints()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    private func showAlert(type:AlertType){
        func setupAlert(customAlert:UIViewController){
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.modalTransitionStyle = .crossDissolve
        }
        switch type {
        case .expense:
            let  customAlert = self.storyboard?.instantiateViewController(withIdentifier: "AlertExpenseView") as! AddExpenseItemAlertView
            setupAlert(customAlert: customAlert)
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
        case .income:
            let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "AlertIncomeView") as! AddIncomesItemAlertView
            setupAlert(customAlert: customAlert)
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
        }
        
    }
    
    
}
extension MainScreenViewController:AddExpenseItemAlertDelegate{
    func addButtonTapped(amount: Double) {
        //TODO:Category
        viewModel.addExpensesItem(amount: amount, category: .other, comment: "some", date: Date())
        viewModel.updateChart()
    }
    
    func cancelButtonTapped() {
        
    }
    
}

extension MainScreenViewController:AddIncomesItemAlertDelegate{
    func addIncomeButtonTapped(amount: Double) {
        viewModel.addIncomesItem(amount: amount, source: .salary, date: Date())
        viewModel.updateChart()
    }
    
    func cancelIncomeButtonTapped() {
        
    }
    
    
    
}
extension MainScreenViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let dataSet = chartView.data?.dataSets[highlight.dataSetIndex]{
            let sliceIndex:Int = dataSet.entryIndex(entry: entry)
            viewModel.showInfo.onNext(sliceIndex)
            print("Selected slice index: \(sliceIndex)")
        }
    }
}

