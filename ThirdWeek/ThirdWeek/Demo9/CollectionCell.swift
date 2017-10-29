//
//  CollectionCell.swift
//  Demo9
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var numberLabel: UILabel = {
        let label = UILabel.init(frame: contentView.bounds)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    private func setupUI() {
        self.backgroundColor = UIColor.brown

        numberLabel.center = contentView.center
        
        contentView.addSubview(numberLabel)
    }
}
