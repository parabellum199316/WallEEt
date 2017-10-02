//
//  ExpenseDetailsViewController.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class ExpenseDetailsViewController: UIViewController {
    var viewModel: ExpenseDetailsViewModelType!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Details"
        // Do any additional setup after loading the view.
    }

    @IBAction func close(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.close()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("VC DEINIT")
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
