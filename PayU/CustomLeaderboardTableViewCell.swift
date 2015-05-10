//
//  CustomLeaderboardTableViewCell.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/10/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class CustomLeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
