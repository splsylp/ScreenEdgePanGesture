//
//  TabBarController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addAllChildVcs()
        self.tabBar.tintColor = UIColor.Main
        UITabBar.appearance().backgroundColor = UIColor.Gray
    }
    
    // 添加所有的子控制器
    func addAllChildVcs() {
        
        self.addOneChildViewController(HomeController(), title: "首页", imageName: "footer_home_hui", selectedImageName: "footer_home")
        
        self.addOneChildViewController(LearnController(), title: "学习", imageName: "btn_study_gray", selectedImageName: "btn_study_blue")
        
        self.addOneChildViewController(SearchController(), title: "发现", imageName: "btn_faxian_gtay", selectedImageName: "btn_faxian_blue")
    }
    
    // 创建子控制器
    func addOneChildViewController(_ childVC:UIViewController, title:String, imageName:String, selectedImageName:String) {
        
        childVC.title = title;
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let nav = NavigationController(rootViewController:childVC)
        self.addChildViewController(nav)
    }
}
