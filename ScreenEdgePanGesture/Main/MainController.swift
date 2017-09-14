//
//  MainController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootController = TabBarController()
        let leftViewController = LeftController()
        let drawerMenuController:DrawerMenuController = DrawerMenuController()
        drawerMenuController.rootViewController = rootController
        drawerMenuController.leftViewController = leftViewController
        drawerMenuController.needSwipeShowMenu = true
        
        UIApplication.shared.delegate?.window!?.rootViewController = drawerMenuController
    }
}
