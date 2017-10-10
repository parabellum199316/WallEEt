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

class MainScreenViewController: UIViewController,StoryboardInitializable {
    var viewModel:MainScreenViewModel!
    private let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var addExpense: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var toDetailsButton: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        toDetailsButton.rx.tap.bind(to:viewModel.showDetails).disposed(by: disposeBag)
        
        viewModel.accItems.bind(to: tableView.rx.items(cellIdentifier: "AccItemCell", cellType: MainScreenTableViewCell.self)){
            row, item, cell in
            let cellVM = MainScreenTableViewCellViewModel(accItem: item)
            cell.viewModel = cellVM
            cell.configure()
        }.addDisposableTo(disposeBag)
        
    }
    
    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        viewModel.addExpensesItem(amount: 30, comment: "some", date: Date())
    }
    
    @IBAction func addIncomeButtonTapped(_ sender: Any) {
        viewModel.addIncomesItem(amount: 50, source: .salary, date: Date())
    }
    


}

