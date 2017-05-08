//
//  AlphaTransition.swift
//  ETNews
//
//  Created by Millman YANG on 2017/4/24.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit

class AlphaTransition: BaseNavTransition , UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let to   = transitionContext.viewController(forKey: .to)
        
        to?.view.alpha = 0.0
        container.addSubview(to!.view)
        switch self.operation {
        case .push:
            UIView.animate(withDuration: config.duration, animations: {
                to?.view.alpha = 1.0

            }, completion: { (finish) in
                transitionContext.completeTransition(true)
            })
            
        case .pop:
            to?.view.alpha = 1.0
            let from   = transitionContext.view(forKey: .from)
            container.addSubview(from!)
            UIView.animate(withDuration: config.duration, animations: {
                from?.alpha = 0.0
            }, completion: { (finish) in
                from?.removeFromSuperview()
                transitionContext.completeTransition(true)
            })

        default:
            break
        }
    }
}
