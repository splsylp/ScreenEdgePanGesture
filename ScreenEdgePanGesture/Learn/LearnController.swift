//
//  LearnController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class LearnController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let one = OneController()
        let two = TwoController()
        addChildViewController(one)
        addChildViewController(two)
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 44)
        let titles = ["好好", "学习"]
        let contentViews: [UIView] = [one.view, two.view]
        
        // 欢迎使用~ https://github.com/splsylp/LPSliderView
        let sliderView = LPSliderView(frame: frame, titles: titles, contentViews: contentViews)
        sliderView.viewChangeClosure = { index in
            print("滚动至：", index)
        }
        view.addSubview(sliderView)
    }
}
