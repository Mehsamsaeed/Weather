//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Mehsam Saeed on 05/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import UIKit
import Reusable
class SearchTableViewCell: UITableViewCell,NibReusable {
    @IBOutlet weak var cityListLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
