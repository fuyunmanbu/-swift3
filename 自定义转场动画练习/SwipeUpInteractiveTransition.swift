//
//  SwipeUpInteractiveTransition.swift
//  自定义转场动画练习
//
//  Created by 刘志高 on 2016/12/25.
//  Copyright © 2016年 liuzhigao. All rights reserved.


// 定义交互手势

import UIKit

class SwipeUpInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interacting : Bool = false
    fileprivate var shouldComplete : Bool = false
    fileprivate var presentingVC : UIViewController?
    
    
    //传入，并记录控制器
    func wireToViewController(viewController: UIViewController) {
        self.presentingVC = viewController
//        completionSpeed = 0.5
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    // 为控制器添加手势
    fileprivate func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(gesture)
    }
    
    //手势监听方法
    @objc fileprivate func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        switch gestureRecognizer.state {
        case .began:
            self.interacting = true
            self.presentingVC?.dismiss(animated: true, completion: nil)
        case .changed:
            var fraction : Float = Float(translation.y / UIScreen.main.bounds.height)
            fraction = -fminf(fminf(fraction, 0), 1)
            self.shouldComplete = (fraction > 0.5)
            self.update(CGFloat(fraction))
        case .cancelled, .ended:
            self.interacting = false
            if !self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerState.cancelled {
                self.cancel()
            } else {
                self.finish()
            }
            default:break
        }
    }
}
