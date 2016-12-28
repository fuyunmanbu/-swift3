//
//  ModalViewController.swift
//  自定义转场动画练习
//
//  Created by 刘志高 on 2016/12/25.
//  Copyright © 2016年 liuzhigao. All rights reserved.
//

import UIKit

@objc protocol ModalViewControllerDelegate : NSObjectProtocol {
    @objc optional func modalViewControllerDidClickedDismissButton(vc: ModalViewController)
}
class ModalViewController: UIViewController {
    // 定义代理属性
    weak var delegate : ModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc private func buttonClicked() {
//        触发，在OC中是需要用到respondsToSelector方法来判断方法是否存在的，这里的‘？’起到了这样的作用，如果没有的话delegate就为nil
        delegate?.modalViewControllerDidClickedDismissButton!(vc: self)

    }
}
