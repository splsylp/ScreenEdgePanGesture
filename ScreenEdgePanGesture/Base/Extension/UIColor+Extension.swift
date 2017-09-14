//
//  UIColor+Extension.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// RGB颜色
    class func RGB(_ r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 主色调-蓝色
    class var Main: UIColor {
        return UIColor(red: 74/255.0, green: 163/255.0, blue: 243/255.0, alpha: 1.0)
    }
    
    /// 项目主颜色--按压
    class var MainPress: UIColor {
        return UIColor(red: 44/255.0, green: 126/255.0, blue: 199/255.0, alpha: 1.0)
    }
    
    /// 红色
    class var Red: UIColor {
        return UIColor(red: 252/255.0, green: 106/255.0, blue: 125/255.0, alpha: 1.0)
    }
    
    /// 项目主颜色--按压
    class var RedPress: UIColor {
        return UIColor(red: 235/255.0, green: 70/255.0, blue: 90/255.0, alpha: 1.0)
    }
    
    /// 灰色背景颜色
    class var Gray: UIColor {
        return UIColor(red: 242/255.0, green: 243/255.0, blue: 248/255.0, alpha: 1.0)
    }
    
    /// 分割线颜色
    class var Line: UIColor {
        return UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    }
    
    /// 一级文字颜色
    class var Font1st: UIColor {
        return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    /// 二级文字颜色
    class var Font2nd: UIColor {
        return UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    /// 三级文字颜色
    class var Font3rd: UIColor {
        return UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    }
}
