//
//  Demo11CollectionViewCell.swift
//  Demo11
//
//  Created by Stan on 2017-11-04.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class Demo11CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
         contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
    }
}
