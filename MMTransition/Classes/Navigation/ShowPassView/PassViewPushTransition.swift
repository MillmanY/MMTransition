//
//  PassViewPushTransition.swift
//  ETNews
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit
public class PassViewPushTransition: BaseNavTransition, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let helper = PassViewHelper(transitionContext: transitionContext, config: self.config)
        switch self.operation {
        case .push:
            helper.goAction()
        case .pop:
            helper.backAction(isNavigation: true)
        default:
            break
        }
    }
}
