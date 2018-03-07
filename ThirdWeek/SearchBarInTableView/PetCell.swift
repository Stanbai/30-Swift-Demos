//
//  PetCell.swift
//  SearchBarInTableView
//
//  Created by Stan on 2018-03-05.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
