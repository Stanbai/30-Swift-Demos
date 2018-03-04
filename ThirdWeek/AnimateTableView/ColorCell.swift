//
//  ColorCell.swift
//  AnimateTableView
//
//  Created by Stan on 2018-03-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    
    let gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}

extension ColorCell {
    fileprivate func setupUI() {

        let color1 = UIColor.init(white: 1.0, alpha: 0.2).cgColor
        let color2 = UIColor.init(white: 1.0, alpha: 0.1).cgColor
        let color3 = UIColor.clear.cgColor
        let color4 = UIColor.init(white: 1.0, alpha: 0.05).cgColor
        
        gradientLayer.colors = [color1,color2,color3,color4]
        gradientLayer.locations = [0.0,0.2,0.9,1.0]
        
        layer.addSublayer(gradientLayer)
        
        self.accessoryType = .none
    }
}
