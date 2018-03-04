//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Stan on 2018-03-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 4
        }
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
