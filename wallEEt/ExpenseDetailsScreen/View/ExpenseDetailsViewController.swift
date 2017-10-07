//
//  ExpenseDetailsViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExpenseDetailsViewController: UIViewController,StoryboardInitializable{
    var viewModel: ExpenseDetailsViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.titleText
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        closeButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }

    
    
    deinit {
        print("dettails deinit")
    }
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
