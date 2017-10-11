//
//  AddAccountItemAlertView.swift
//  wallEEt
//
//  Created by ParaBellum on 10/11/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

protocol AddExpenseItemAlertDelegate{
    func addButtonTapped(amount:Double)
    func cancelButtonTapped()
}
class AddExpenseItemAlertView:UIViewController{
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func add(_ sender: Any) {
        textField.resignFirstResponder()
        delegate?.addButtonTapped(amount: Double(textField.text!)!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        textField.resignFirstResponder()
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    var delegate:AddExpenseItemAlertDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    func setupView(){
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView(){
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4) {
            self.alertView.alpha = 1
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        }
    }
    
    
    
    
}
