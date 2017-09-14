//
//  S1Controller.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class S1Controller: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 禁用屏幕边缘侧滑手势
        let navController = navigationController as? NavigationController
        navController?.enableScreenEdgePanGestureRecognizer(false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 启用屏幕边缘侧滑手势
        let navController = navigationController as? NavigationController
        navController?.enableScreenEdgePanGestureRecognizer(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "S1"
        
        // 自定义返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("S2", for: .normal)
        jumpBtn.backgroundColor = UIColor.Main
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
        
        let label = UILabel(frame: CGRect(x: 20, y: jumpBtn.bottom + 100, width: SCREEN_WIDTH - 40, height: 80))
        label.text = "该页面禁止屏幕边缘侧滑，展示禁用、启用屏幕边缘侧滑手势功能"
        label.textColor = UIColor.Font1st
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.Gray
        view.addSubview(label)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(S2Controller(), animated: true)
    }
    
    func backBtnClicked() {
        
        print("S1自定义返回按钮点击")
        
        // 1、对于一些特殊情况进行一些判断，不满足条件不允许退出
//        if xxx {
//            return
//        }
        
        // 2、返回到指定的某个页面
//        navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
        navigationController?.popViewController(animated: true)
    }
}
