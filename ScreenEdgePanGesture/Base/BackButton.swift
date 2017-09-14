//
//  BackButton.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

/// 导航栏左侧返回按钮
class BackButton: UIButton {

    init(target: Any, action: Selector) {
        super.init(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        commonInit(target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(target: Any, action: Selector) {
        
        self.adjustsImageWhenHighlighted = false
        self.setBackgroundImage(UIImage(named: "fanhui_new"), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: "fanhui_yin_new"), for: UIControlState.highlighted)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(self.width > 20 ? self.width - 20 : self.width), bottom: 0, right:0)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
