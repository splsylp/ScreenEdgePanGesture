//
//  OneController.swift
//  LPSliderView
//
//  Created by Tony on 2017/8/2.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class OneController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 242/255.0, green: 243/255.0, blue: 248/255.0, alpha: 1.0)
        navigationItem.title = "One"
        
        // 跳转按钮
        let jumpBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        jumpBtn.centerX = view.centerX
        jumpBtn.setTitle("Two", for: .normal)
        jumpBtn.backgroundColor = UIColor.Main
        jumpBtn.addTarget(self, action: #selector(jumpBtnClicked), for: .touchUpInside)
        view.addSubview(jumpBtn)
    }
    
    func jumpBtnClicked() {
        navigationController?.pushViewController(TwoController(), animated: true)
    }
}
