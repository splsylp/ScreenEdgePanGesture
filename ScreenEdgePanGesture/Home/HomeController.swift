//
//  HomeController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // 导航栏左侧按钮
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        leftBtn.setImage(UIImage(named: "nav_leftsidebar_nor"), for: .normal)
        leftBtn.setImage(UIImage(named: "nav_leftsidebar_sel"), for: .highlighted)
        leftBtn.addTarget(self, action: #selector(leftBtnClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("H1", for: .normal)
        jumpBtn.backgroundColor = UIColor.Main
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
        
        let label = UILabel(frame: CGRect(x: 20, y: jumpBtn.bottom + 100, width: SCREEN_WIDTH - 40, height: 120))
        label.text = "返回后偶现的导航栏标题水平位置偏移、抖动、文字变淡等问题是由模拟器所导致，真机下是没有问题的！！！"
        label.textColor = UIColor.RedPress
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.Gray
        view.addSubview(label)
    }
    
    func leftBtnClicked() {
        drawerMenuController()?.showLeftViewController(true)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(H1Controller(), animated: true)
    }
}
