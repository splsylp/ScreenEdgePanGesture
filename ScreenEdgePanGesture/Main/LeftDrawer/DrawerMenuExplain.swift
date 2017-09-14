//
//  DrawerMenuExplain.swift
//  DrawerMenuController Controller
//
//  Created by SunSet on 14-7-18.
//  Copyright (c) 2014年 zhaokaiyuan. All rights reserved.
// qq 623046455 邮箱 zhaokaiyuan99@163.com

import Foundation

/*
xcode 6 beat3编写的   xcode 6 beat1 xcode 6 beat2 编译不通过自己去修复

  默认值可以自行修改
  minScale:CGFloat = 0.8                  //root 最小缩放
  leftViewShowWidth:CGFloat = 220         //左边View 长度
  leftSmoothWidth:CGFloat = 80          //滑动是缩放后平滑距离
  rightViewShowWidth:CGFloat = 220        //右边
  rightSmoothWidth:CGFloat = 80
  directionAnimationDuration:CGFloat =  0.8        //左右滑动动画时间
  backAnimationDuration:CGFloat =  0.35            //返回动画时间
  bounces:Bool = true                              //滑动边界回弹
  springBack:Bool = true  //是否支持回弹效果 object—c 只有ios7 以上有效 swift ios7以下未知 没有测试过
  springBackDuration:CGFloat = 0.5        //回弹时间
  SpringVelocity:CGFloat = 0.5
  blackCoverView!.backgroundColor         //蒙版颜色
  //左滑
  showLeftViewController(animated: Bool)
  //右滑
  showRightViewController(animated: Bool)
  //返回中间
  hideSideViewController(animated: Bool)

  如果自定义实现效果  可以滑动时修改
  leftSideView mainContentView  rightSideView 左中右3个view
  写出自己想要的动画 
  //参考 CustomMenuController 继承后在改效果 
  //或者 设置DrawerMenuControllerDelegate 
  //在CustomlayoutViewWithOffset重写效果


*/