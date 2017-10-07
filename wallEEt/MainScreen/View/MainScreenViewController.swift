//
//  ViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 8/30/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    var viewModel: MainScreenViewModelType!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toDetailsVC(_ sender: Any) {
        viewModel.nextView()
    }
    
    


}

