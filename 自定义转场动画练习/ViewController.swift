//
//  ViewController.swift
//  自定义转场动画练习
//
//  Created by 刘志高 on 2016/12/25.
//  Copyright © 2016年 liuzhigao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let presentAnimation = BouncePresentAnimation()
    let dismissAnimation = NormalDismissAnimation()
    let transitionController = SwipeUpInteractiveTransition()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func buttonClicked() {
        let mvc = ModalViewController()
        //定义转场动画代理
        mvc.transitioningDelegate = self
        //定义自身代理
        mvc.delegate = self
        self.transitionController.wireToViewController(viewController: mvc)
        self.present(mvc, animated: true) { 
            
        }
    }
}
// MARK: - 协议代理方法
extension ViewController : ModalViewControllerDelegate ,UIViewControllerTransitioningDelegate {
    //视图二 dismis 代理
    func modalViewControllerDidClickedDismissButton(vc: ModalViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
    
    //返回怎样的 present 动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.presentAnimation
    }
    //返回怎样的 dismiss 动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimation
    }
    //手势
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.transitionController.interacting ? self.transitionController : nil
    }
}

