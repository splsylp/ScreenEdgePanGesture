//
//  LeftController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class LeftController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Red
        navigationItem.title = "Left"
        
        let jumpBtn = UIButton(frame: CGRect(x: 60, y: 164, width: 100, height: 40))
        jumpBtn.setTitle("Setting", for: .normal)
        jumpBtn.backgroundColor = UIColor.Main
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
    }
    
    func jumpBtnClicked() {
        
        let drawer = drawerMenuController()
        drawer?.hideSideViewController(false)
        
        let tab = drawer?.rootViewController
        let navController = tab?.viewControllers?[(tab?.selectedIndex ?? 0)] as? NavigationController
        navController?.pushViewController(SettingController(), animated: true)
    }
}
