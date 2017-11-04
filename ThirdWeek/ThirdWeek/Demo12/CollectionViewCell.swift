//
//  CollectionViewCell.swift
//  Demo12
//
//  Created by Stan on 2017-10-30.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var name: String? {
        didSet {
            for view in contentView.subviews {
                view.removeFromSuperview()
            }

            setupUI()
        }
    }
    lazy var imgView: UIImageView = {
        let iv = UIImageView.init(frame: CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.width))
        iv.image = #imageLiteral(resourceName: "bolong")
        return iv
    }()
    
    private func setupUI() {
        contentView.addSubview(imgView)
        
        let label = UILabel(font: .preferredFont(forTextStyle: .body), textColor: .darkText, text: name)
        label.textAlignment = .center
        contentView.addSubview(label)
        
        label.frame = CGRect(x: 0, y: imgView.frame.maxY + 10, width: contentView.bounds.size.width, height: 20)
    }
}
