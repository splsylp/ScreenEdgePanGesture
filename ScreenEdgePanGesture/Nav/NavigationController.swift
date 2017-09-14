//
//  NavigationController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    fileprivate var isEnableEdegePan = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.Main
        //navigationBar.setBackgroundImage(UIImage(named: "navbg"), forBarMetrics: UIBarMetrics.Default)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.auto(size: 18)]
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    /// 启用、禁用屏幕边缘侧滑手势
    func enableScreenEdgePanGestureRecognizer(_ isEnable: Bool) {
        
        isEnableEdegePan = isEnable
    }
    
    /// 获取屏幕边缘侧滑手势
    func getScreenEdgePanGestureRecognizer() -> UIScreenEdgePanGestureRecognizer? {
        
        var edgePan: UIScreenEdgePanGestureRecognizer?
        if let recognizers = view.gestureRecognizers, recognizers.count > 0 {
            for recognizer in recognizers {
                if recognizer is UIScreenEdgePanGestureRecognizer {
                    edgePan = recognizer as? UIScreenEdgePanGestureRecognizer
                    break
                }
            }
        }
        return edgePan
    }
    
    // 导航栏返回按钮点击
    @objc fileprivate func backBtnClicked() {
        
        popViewController(animated: true)
        if viewControllers.count == 1 { // 回到首页，打开左侧抽屉手势
            drawerMenuController()?.needSwipeShowMenu = true
        }
    }
}


// MARK: - delegate
extension NavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if !isEnableEdegePan { // 禁用边缘侧滑手势
            return false
        }
        return childViewControllers.count > 1
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count == 1 { // 回到首页，打开左侧抽屉手势
            drawerMenuController()?.needSwipeShowMenu = true
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            // 隐藏tabBar底部
            viewController.hidesBottomBarWhenPushed = true
            // 关闭首页左侧抽屉手势
            drawerMenuController()?.needSwipeShowMenu = false
            //设置统一的返回按钮
            let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}

