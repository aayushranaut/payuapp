//
//  CustomPortfolioTableViewCell.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/10/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class CustomPortfolioTableViewCell: UITableViewCell {
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockIcon: UIImageView!
    @IBOutlet weak var stockProfit: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
