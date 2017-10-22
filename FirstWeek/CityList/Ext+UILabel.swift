//
//  Ext+UILabel.swift
//  NECHandBookVersionTwo
//
//  Created by Stan on 2017-08-02.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

extension UILabel {
    /// 快速创建一个lable
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - textColor: 字体颜色
    ///   - text: 文字
    
    
    /// 创建一个有文字、字体、颜色的Label
    ///
    /// - Parameters:
    ///   - font: UIFont
    ///   - textColor: 文字颜色
    ///   - text: 文字内容
    convenience init(font: UIFont, textColor: UIColor, text: String? = nil){
        self.init()
        // 字体大小
        self.font = font
        // 字体颜色
        self.textColor = textColor
        // 设置text
        self.text = text
    }
}

