//
//  ExpensesIncomesInfoViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 10/24/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExpensesIncomesInfoViewController: UIViewController,StoryboardInitializable {
    let disposeBag = DisposeBag()
    var viewModel:ExpensesIncomesInfoViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.close.onNext(())
    }

   

}
