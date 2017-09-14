//
//  UIFont_Extension.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func auto(size: CGFloat) -> UIFont {
        let autoSize = size * SCREEN_WIDTH / 375.0
        return UIFont.systemFont(ofSize: autoSize)
    }
}
