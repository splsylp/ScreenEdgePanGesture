//
//  Header.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

/// 屏幕宽度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/// 屏幕高度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

/// 自适应屏幕宽度
func FIT_SCREEN_WIDTH(_ size: CGFloat) -> CGFloat {
    return size * SCREEN_WIDTH / 375.0
}

/// 自适应屏幕高度
func FIT_SCREEN_HEIGHT(_ size: CGFloat) -> CGFloat {
    return size * SCREEN_HEIGHT / 667.0
}

/// 自适应屏幕字体大小
func AUTO_FONT(_ size: CGFloat) -> UIFont {
    let autoSize = size * SCREEN_WIDTH / 375.0
    return UIFont.systemFont(ofSize: autoSize)
}



/// 根控制器--抽屉
func drawerMenuController() -> DrawerMenuController? {
    let drawerVC = UIApplication.shared.keyWindow?.rootViewController as? DrawerMenuController
    return drawerVC
}
