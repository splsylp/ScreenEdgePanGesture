//
//  SearchController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "Search"
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("S1", for: .normal)
        jumpBtn.backgroundColor = UIColor.Main
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(S1Controller(), animated: true)
    }
}
