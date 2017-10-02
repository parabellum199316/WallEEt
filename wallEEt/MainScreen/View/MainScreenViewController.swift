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
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.stringToShow
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func toDetailsVC(_ sender: Any) {
        viewModel.nextView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

