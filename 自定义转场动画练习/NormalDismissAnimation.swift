//
//  NormalDismissAnimation.swift
//  自定义转场动画练习
//
//  Created by 刘志高 on 2016/12/25.
//  Copyright © 2016年 liuzhigao. All rights reserved.


// 定义 Dismiss 动画

import UIKit

class NormalDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    //返回动画的执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    //动画细节
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1. 从上下文获取控制器 toVC
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
        else {
            return
        }
        
        //2. 初始化 toVC 控制器
        let screenBounds = UIScreen.main.bounds
        //2.1 初始时的 frame     (0,0,414,736)
        let initFrame = transitionContext.finalFrame(for: fromVC)
        //2.2 结束时的 frame     (0,-736,414,736)
        let finalFrame = CGRect(origin: CGPoint(x: 0, y: -screenBounds.height), size: initFrame.size)
        
        //3. 将 toVC 控制器的view加入到容器中
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)
        
        //4. 开始动画
        let duration = self.transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration,
                         animations: { 
                            fromVC.view.frame = finalFrame
                            fromVC.view.alpha = 0
        },
                         completion: { (_) in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
