//
//  UIButton+Extension.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

extension UIButton {
    
    // 扩大按钮的响应区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        var bounds = self.bounds
        let width = max(44 - bounds.size.width, 0)
        let height = max(44 - bounds.size.height, 0)
        bounds = bounds.insetBy(dx: -0.5 * width, dy: -0.5 * height)
        return bounds.contains(point)
    }
}
