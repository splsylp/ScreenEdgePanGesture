//
//  DrawerMenuExplain.swift
//  DrawerMenuController Controller
//
//  Created by SunSet on 14-7-18.
//  Copyright (c) 2014年 zhaokaiyuan. All rights reserved.
// qq 623046455 邮箱 zhaokaiyuan99@163.com


import UIKit

enum MenuDirection {
    case leftMenu
    case rightMenu
    case middleMenu
}



@objc protocol DrawerMenuControllerDelegate : NSObjectProtocol {
    
    //滑动变化
    @objc optional func CustomlayoutViewWithOffset(_ xoffset:CGFloat,menuController:DrawerMenuController)
}



class DrawerMenuController: UIViewController ,UIGestureRecognizerDelegate, UITabBarControllerDelegate {
     var delegate:DrawerMenuControllerDelegate?
    
    
    //是否边界影子
    var showBoundsShadow:Bool =  true {
    willSet{
        
    }
    didSet{
        
    }
    
    }
    
    //是否能滑动
    var needSwipeShowMenu:Bool = true
    
    {
    willSet{
        
    }
    didSet{
        if needSwipeShowMenu{
            self.view.addGestureRecognizer(movePan!)
        }else{
            self.view.removeGestureRecognizer(movePan!)
        }
    }
    
    }
    
    
    
    var minScale:CGFloat = 0.8                  //root 最小缩放
    var leftViewShowWidth:CGFloat = FIT_SCREEN_WIDTH(258) //左边View 长度
    var leftSmoothWidth:CGFloat = 80          //滑动是缩放后平滑距离
    var rightViewShowWidth:CGFloat = 220        //右边
    var rightSmoothWidth:CGFloat = 80
    var directionAnimationDuration:CGFloat =  0.8        //左右滑动动画时间
    var backAnimationDuration:CGFloat =  0.35            //返回动画时间
    var bounces:Bool = true                              //滑动边界回弹
    var springBack:Bool = true  //是否支持回弹效果 object—c 只有ios7 以上有效 swift ios7以下未知 没有测试过
    var springBackDuration:CGFloat = 0.5        //回弹时间
    var SpringVelocity:CGFloat = 0.5
    
    
    var movePan:UIPanGestureRecognizer?
    var blackCoverPan:UIPanGestureRecognizer?
    var blackTapPan:UITapGestureRecognizer?
    
    var startPanPoint:CGPoint = CGPoint(x: 0, y: 0)
    var panMovingRightOrLeft:Bool = false
    
    var panRight:Bool = false
    var panLeft:Bool = false
    var isInAnimation:Bool = false
    
    var menuDirection:MenuDirection = MenuDirection.middleMenu
    
    var mainContentView:UIView?
    var leftSideView:UIView?
    var rightSideView:UIView?
    var blackCoverView:UIView?
    
    var rootViewController:TabBarController?{
    willSet{
        if (newValue != nil) {
            rootViewController?.removeFromParentViewController()
            rootViewController?.view.removeFromSuperview();
        }
    }
    didSet{
        if (rootViewController != nil){
            rootViewController?.delegate = self
            self.addChildViewController(rootViewController!)
            var frame:CGRect = CGRect.zero
            let transform:CGAffineTransform  = CGAffineTransform.identity
            frame = self.view.bounds;
            mainContentView!.addSubview(rootViewController!.view)
            mainContentView!.sendSubview(toBack: rootViewController!.view)
            rootViewController!.view!.transform =  transform
            rootViewController!.view!.frame = frame
            if ((((leftViewController?.view.superview) != nil) || ((rightViewController?.view.superview) != nil)) != false) {
                self.showShadow(showBoundsShadow)
            }
        }
    }
    }
    
    var leftViewController:UIViewController?{
    willSet{
        if (newValue != nil) {
            leftViewController?.removeFromParentViewController()
            leftViewController?.view.removeFromSuperview();
        }
        
    }
    didSet{
        if (leftViewController != nil){
            self.addChildViewController(leftViewController!)
            leftViewController!.view.frame = CGRect(x: 0, y: 0, width: leftViewController!.view.frame.size.width,  height: leftViewController!.view.frame.size.height)
            leftSideView!.addSubview(leftViewController!.view)
        }
    }
    }
    
    var rightViewController:UIViewController?{
    willSet{
        if (newValue != nil) {
            rightViewController?.removeFromParentViewController()
            rightViewController?.view.removeFromSuperview();
        }
    }
    didSet{
        if (rightViewController != nil){
            self.addChildViewController(rightViewController!)
            rightViewController!.view.frame = CGRect(x: 0, y: 0, width: rightViewController!.view.frame.size.width,  height: rightViewController!.view.frame.size.height)
            rightSideView!.addSubview(rightViewController!.view)
        }
    }
    }
    
    func showShadow(_ show: Bool)
    {
        mainContentView!.layer.shadowOpacity = show ? 0.6 : 0.0
        if show {
            mainContentView!.layer.cornerRadius = 12
            mainContentView!.layer.shadowOffset = CGSize.zero;
            mainContentView!.layer.shadowRadius = 8.0;
            mainContentView!.layer.shadowPath = UIBezierPath(rect: mainContentView!.bounds).cgPath
            mainContentView!.layer.shadowColor = UIColor.RGB(0, g: 0, b: 0, alpha: 0.6).cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        //滑动手势
        movePan = UIPanGestureRecognizer(target: self, action: #selector(DrawerMenuController.moveViewWithGesture(_:)))
        movePan!.delegate  = self
        mainContentView!.addGestureRecognizer(movePan!)
      
        
        
        blackTapPan = UITapGestureRecognizer(target: self, action: #selector(DrawerMenuController.handleSingleFingerEvent(_:)))
        blackTapPan!.numberOfTouchesRequired = 1; //手指数
        blackTapPan!.numberOfTapsRequired = 1; //tap次数
        blackTapPan!.delegate = self
        blackCoverView!.addGestureRecognizer(blackTapPan!)
        blackTapPan!.isEnabled = false
       
        
        blackCoverPan = UIPanGestureRecognizer(target: self, action: #selector(DrawerMenuController.blackCoverPanGesture(_:)))
        blackCoverPan!.delegate  = self
        blackCoverView!.addGestureRecognizer(blackCoverPan!)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubviews(){
        leftSideView = UIView(frame: self.view.bounds)
        self.view.addSubview(leftSideView!)
        rightSideView = UIView(frame: self.view.bounds)
         self.view.addSubview(rightSideView!)
        mainContentView = UIView(frame: self.view.bounds)
        self.view.addSubview(mainContentView!)
         blackCoverView = UIView(frame: self.view.bounds)
        mainContentView!.addSubview(blackCoverView!)
        blackCoverView!.backgroundColor = UIColor.black
        blackCoverView!.alpha = 0
        blackCoverView!.isHidden = true
    }
    
    func willShowLeftViewController(){
        rightSideView!.isHidden = true
        leftSideView!.isHidden = false
        self.view.sendSubview(toBack: rightSideView!)
        
        blackCoverView!.isHidden = false
    }
    
    func willShowRightViewController(){
        
        rightSideView!.isHidden = false
        leftSideView!.isHidden = true
        self.view.sendSubview(toBack: leftSideView!)
         blackCoverView!.isHidden = false
    }
    
  
    func handleSingleFingerEvent(_ sender:UITapGestureRecognizer ){
         self.hideSideViewController(true)
    }
    
    //在遮罩页面添加滑动手势
    func blackCoverPanGesture(_ sender: UIPanGestureRecognizer){
        
        if (blackCoverPan!.state == UIGestureRecognizerState.began) {
            startPanPoint = mainContentView!.frame.origin
            if mainContentView!.frame.origin.x == 0 {
                self.showShadow(showBoundsShadow)
            }
        }
        let currentPostion = blackCoverPan!.translation(in: self.view)
        let xoffset:CGFloat = startPanPoint.x + currentPostion.x
        
        //禁止右滑
        if xoffset < 0{
            if (mainContentView?.frame.origin.x)! > CGFloat(0) {
                self.hideSideViewController(true)
            }
            return
        }
        
        if xoffset > 0 {
            if (leftViewController != nil) {
                if bounces{
                    self.layoutCurrentViewWithOffset(xoffset)
                }else {
                    self.layoutCurrentViewWithOffset(leftViewShowWidth < xoffset ? leftViewShowWidth : xoffset)
                }
            }
        }
        
        if (blackCoverPan!.state == UIGestureRecognizerState.ended) {
            if mainContentView!.frame.origin.x == 0 {
                self.showShadow(false)
            }else {
                self.hideSideViewController(true)
            }
        }
    }
    
    func moveViewWithGesture(_ sender: UIPanGestureRecognizer)
    {
        if menuDirection != MenuDirection.middleMenu {
            return
        }
        
        if isInAnimation {
            return
        }
        
        let velocity:CGPoint=movePan!.velocity(in: self.view)
        
        if ( movePan!.state == UIGestureRecognizerState.began) {
            startPanPoint = mainContentView!.frame.origin
            if mainContentView!.frame.origin.x == 0 {
                self.showShadow(showBoundsShadow)
            }
        } 
        let currentPostion = movePan!.translation(in: self.view)
        let xoffset:CGFloat = startPanPoint.x + currentPostion.x
        //禁止右滑
        if xoffset < 0 {
            if (mainContentView?.frame.origin.x)! > CGFloat(0) {
                self.hideSideViewController(true)
            }
            return
        }
        
        if xoffset > 0 {
            if (leftViewController != nil) {
                if !panLeft {
                    panLeft = true
                    self.willShowLeftViewController()
                    panRight = false
                }
                panLeft = true
                self.willShowLeftViewController()
                panRight = false
                if bounces{
                    self.layoutCurrentViewWithOffset(xoffset)
                }else {
                    self.layoutCurrentViewWithOffset(leftViewShowWidth < xoffset ? leftViewShowWidth : xoffset)
                }
               
            }
            
        }else if xoffset < 0{
            if (rightViewController != nil) {
                if !panRight {
                    panRight = true
                    self.willShowRightViewController()
                    panLeft = false
                }
                panRight = true
                self.willShowRightViewController()
                panLeft = false
                if bounces {
                    self.layoutCurrentViewWithOffset(xoffset)
                }else{
                    self.layoutCurrentViewWithOffset(rightViewShowWidth < abs(xoffset) ? -rightViewShowWidth : xoffset)
                }
            }
        }
        
        if ( movePan!.state == UIGestureRecognizerState.ended) {
            if mainContentView!.frame.origin.x == 0 {
                self.showShadow(false)
            }else {
                if panMovingRightOrLeft && mainContentView!.frame.origin.x > 20 {
                    self.showLeftViewController(true)
                }else if !panMovingRightOrLeft &&  mainContentView!.frame.origin.x < -20 {
                    self.showRightViewController(true)
                }else {
                    self.hideSideViewController(true)
                }
            }
        }else{
            if velocity.x > 0{
                panMovingRightOrLeft = true
            }else if velocity.x < 0 {
                panMovingRightOrLeft = false
            }
        }
    }
    
    func showLeftViewController(_ animated:Bool){
        if ( (leftViewController == nil)) {
            return;
        }
        menuDirection = MenuDirection.leftMenu
        self.willShowLeftViewController()
        var animatedTime:TimeInterval  = 0
        if (animated) {
            animatedTime = Double(abs(leftViewShowWidth - mainContentView!.frame.origin.x) / leftViewShowWidth * directionAnimationDuration)
            
        }
        blackTapPan!.isEnabled = true
        blackCoverPan!.isEnabled = true
        isInAnimation = true
        self.showAnimationEffects(animatedTime, ShowWidth: self.leftViewShowWidth,pletion: {  (finish:Bool) -> Void in
            self.isInAnimation = false
            })
    }
    
    func showAnimationEffects(_ animatedTime:TimeInterval,ShowWidth:CGFloat, pletion:@escaping (_ finish:Bool)->Void){
        isInAnimation = true
        let Version:NSString = UIDevice.current.systemVersion as NSString
        if springBack &&   Version.floatValue >= 7.0 &&  ShowWidth != 0{
            UIView.animate(withDuration: animatedTime , delay: 0, usingSpringWithDamping: CGFloat( springBackDuration) , initialSpringVelocity: SpringVelocity, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.layoutCurrentViewWithOffset(ShowWidth)
                }, completion:  {
                    (finish:Bool) -> Void in
                    self.isInAnimation = false
                    pletion(finish)
                })
            
        }else {
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            UIView.animate(withDuration: animatedTime, animations: {
                self.layoutCurrentViewWithOffset(ShowWidth)
                
                }, completion: {
                    (finish:Bool) -> Void in
                    
                    if  finish{
                        pletion(finish)
                    }
                })
            
        }
        
    }
    
    func showRightViewController(_ animated:Bool){
        if ( (rightViewController == nil)) {
            return;
        }
        menuDirection = MenuDirection.rightMenu
        self.willShowRightViewController()
        var animatedTime:TimeInterval  = 0
        if (animated) {
            animatedTime = Double(abs(rightViewShowWidth + mainContentView!.frame.origin.x) / rightViewShowWidth * directionAnimationDuration)
            
        }
         blackTapPan!.isEnabled = true
        blackCoverPan!.isEnabled = true
        isInAnimation = true
        self.showAnimationEffects(animatedTime, ShowWidth: -self.rightViewShowWidth,pletion: {  (finish:Bool) -> Void in
            self.isInAnimation = false
            })
    }
    
    //返回
    func hideSideViewController(_ animated:Bool){
        self.showShadow(false)
        menuDirection = MenuDirection.middleMenu
        var animatedTime:TimeInterval  = 0
        if (animated) {
            animatedTime = Double(abs( mainContentView!.frame.origin.x / (mainContentView!.frame.origin.x > 0 ? leftViewShowWidth : rightViewShowWidth ) * backAnimationDuration))
        }
        isInAnimation = true
        self.showAnimationEffects(animatedTime, ShowWidth: 0, pletion: {(finish:Bool) -> Void in
            self.isInAnimation = false
            if finish {
                self.blackCoverView!.isHidden = true
                self.blackTapPan!.isEnabled = false
                self.blackCoverPan!.isEnabled = false
                self.panLeft = false
                self.panRight = false
                self.rightSideView!.isHidden = true
                self.leftSideView!.isHidden = true
            }
            })
     }
    
    
    func layoutCurrentViewWithOffset(_ xoffset:CGFloat){
        
        if  ((delegate?.CustomlayoutViewWithOffset) != nil) {
            delegate?.CustomlayoutViewWithOffset?(xoffset,menuController: self)
            return
        }
        self.mainCurrentViewWithOffset(xoffset)
       
    }
    
    //左右滑动的方法
    func mainCurrentViewWithOffset(_ xoffset:CGFloat){
        
//        blackCoverView!.alpha = abs(xoffset/leftViewShowWidth) * 0.5
        // 需要亮一点的效果，把黑色蒙版透明度设置很低
        blackCoverView!.alpha = abs(xoffset/leftViewShowWidth) * 0.05
        
        var scale:CGFloat = 0.0
        if xoffset > 0 {
            scale = 1 - abs(xoffset/(leftViewShowWidth-leftSmoothWidth)) * (1-minScale)
        }else if  xoffset < 0 {
            let rightMinScale = 1 as CGFloat// 右侧滑动不缩放
            scale = 1 - abs(xoffset/(rightViewShowWidth-rightSmoothWidth)) * (1-rightMinScale)
        }else {
            scale = 1
        }
        scale = max(scale, minScale)
        mainContentView!.transform =  CGAffineTransform.identity.scaledBy(x: scale,y: scale)
        var newFrame = CGRect(x: xoffset,  y: (self.view.frame.size.height - self.view.frame.size.height * scale )/2 , width: self.view.frame.size.width * scale, height: self.view.frame.size.height * scale)
        
        if xoffset > 0 {
            newFrame.origin.x  = xoffset
        }else if xoffset < 0 {
            newFrame.origin.x  = xoffset +  (1.0 - scale) * self.view.frame.size.width
            
        }
        mainContentView!.frame = newFrame
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
//        let vc = (viewController as! NavigationController).viewControllers[0]
//        if vc.isKind(of: LiveController.self) {
//            if isVisitor() {
//                
//                let nav = rootViewController?.childViewControllers[(rootViewController?.selectedIndex)!] as! NavigationController
//                nav.pushViewController(VisterLogVC(), animated: true)
//                return false
//            }
//            return true
//        }
        return true
    }
}

