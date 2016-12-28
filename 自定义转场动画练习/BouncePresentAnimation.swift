//
//  BouncePresentAnimation.swift
//  自定义转场动画练习
//
//  Created by 刘志高 on 2016/12/25.
//  Copyright © 2016年 liuzhigao. All rights reserved.


// 定义 present 动画

import UIKit

class BouncePresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    //返回动画的执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    //动画细节
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1. 从上下文获取控制器 toVC
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }

        //2. 初始化 toVC 控制器
        let screenBounds = UIScreen.main.bounds
          //2.1 获取切换结束时控制器的 frame
        let finalFrame = transitionContext.finalFrame(for: toVC)
          //2.2 巧取 CGRectOffset
        toVC.view.frame = CGRect(origin: CGPoint(x: 0, y: screenBounds.height), size: finalFrame.size)
        
        //3. 将 toVC 控制器的view加入到容器中
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        //4. 开始动画
        let duration = self.transitionDuration(using: transitionContext)
        toVC.view.alpha = 0
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: .curveLinear,
                       animations: { 
                        toVC.view.frame = finalFrame
                        toVC.view.alpha = 1
        }) { (_) in
            //5. 报告，完成视图切换
            transitionContext.completeTransition(true)
        }
    }
}
