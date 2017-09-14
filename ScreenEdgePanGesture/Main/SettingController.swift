//
//  SettingController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Gray
        navigationItem.title = "Setting"
        
        // 底部滚动视图
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        scrollView.backgroundColor = view.backgroundColor
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        
        // 解决scrollView滑动手势和屏幕边缘侧滑手势冲突问题
        let navController = navigationController as? NavigationController
        if let edgePan = navController?.getScreenEdgePanGestureRecognizer() {
            scrollView.panGestureRecognizer.require(toFail: edgePan)
        }
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("Left", for: .normal)
        jumpBtn.backgroundColor = UIColor.Red
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        scrollView.addSubview(jumpBtn)
        
        let label = UILabel(frame: CGRect(x: 20, y: jumpBtn.bottom + 100, width: SCREEN_WIDTH - 40, height: 80))
        label.text = "这是一个可以左右滑动的scrollView，展示解决scrollView滑动手势和屏幕边缘侧滑手势冲突的问题"
        label.textColor = UIColor.Font1st
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.Gray
        view.addSubview(label)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(LeftController(), animated: true)
    }
}
