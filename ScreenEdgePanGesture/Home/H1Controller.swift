//
//  H1Controller.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class H1Controller: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "H1"
        
        var topY: CGFloat = 20
        var navH: CGFloat = 64
        if SCREEN_HEIGHT == 812 {
            topY = 44
            navH = 88
        }
        
        // 自定义导航栏视图
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.black
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        navView.addSubview(backBtn)
        
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "H1"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.auto(size: 18)
        navView.addSubview(titleLabel)
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: navView.bottom + 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("H2", for: .normal)
        jumpBtn.backgroundColor = UIColor.Red
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
        
        let label = UILabel(frame: CGRect(x: 20, y: jumpBtn.bottom + 100, width: SCREEN_WIDTH - 40, height: 120))
        label.text = "该页面的导航栏是通过自定义view绘制的，展示从真导航栏页面 -> 假导航栏页面，以及假导航栏页面 -> 真导航栏页面的效果"
        label.textColor = UIColor.Font1st
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.Gray
        view.addSubview(label)
    }
    
    func backBtnClicked() {
        print("H1自定义返回按钮点击")
        navigationController?.popViewController(animated: true)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(H2Controller(), animated: true)
    }
}
