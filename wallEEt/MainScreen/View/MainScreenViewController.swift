//
//  ViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 8/30/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainScreenViewController: UIViewController,StoryboardInitializable {
    var viewModel:MainScreenViewModel!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var toDetailsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.title.bind(to: testLabel.rx.text).disposed(by: disposeBag)
        toDetailsButton.rx.tap.bind(to:viewModel.showDetails).disposed(by: disposeBag)
    }
    
    
    
    


}

