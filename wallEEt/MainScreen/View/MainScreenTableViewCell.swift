//
//  MainScreenTableViewCell.swift
//  wallEEt
//
//  Created by ParaBellum on 10/8/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    
    var viewModel: MainScreenTableViewCellViewModel!
    
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    func configure() {
        amountLabel.text = String(viewModel.amount)
        dateLabel.text = viewModel.stringDate
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
