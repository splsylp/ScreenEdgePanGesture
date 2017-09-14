//
//  S2Controller.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class S2Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "S2"
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        
        if parent == nil {
            print("S2---Pop")
            task()
        }
    }
    
    // 返回前的一些必要操作
    func task() {
        // 在这里执行一些必要操作，比如一些任务的状态数据提交等等
    }
}
