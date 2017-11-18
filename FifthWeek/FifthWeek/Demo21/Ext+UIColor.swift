//
//  Ext+UIColor.swift
//
//  Created by Stan on 2017-07-23.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

extension UIColor {

    /// 根据16进制返回UIColor
    ///
    /// - Parameter rgbValue: ex:0xff9933
    /// - Returns: alpha:1.0
    class func colorWithHex(_ rgbValue:Int) -> UIColor {
        return kRGBColorWithHex(rgbValue, alpha: 1.0)
    }
    
    /// 根据16进制和alpha返回UIColor
    ///
    /// - Parameters:
    ///   - rgbValue: ex:0xffffff(1111 1111 1111 1111 1111 1111) & 0xff0000(1111 1111 0000 0000 0000 0000) -> value:1111 1111 0000 0000 0000 0000
    ///                  r:value >> 16 得到：1111 1111 ->转换为10进制数：255
    ///   - alpha: 透明度
    /// - Returns: UIColor
    class func kRGBColorWithHex(_ rgbValue:Int, alpha:CGFloat) -> UIColor {
        let r : CGFloat = (CGFloat)((rgbValue & 0xFF0000) >> 16) / 255.0
        let g : CGFloat = (CGFloat)((rgbValue & 0xFF00) >> 8) / 255.0
        let b : CGFloat  = (CGFloat)((rgbValue & 0xFF) ) / 255.0
        return UIColor.init(red: r, green: g, blue: b, alpha: alpha)
    }

    
}

