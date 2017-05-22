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
        let container = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to)!
        container.addSubview(toVC.view)
        
        switch self.operation {
        case .push:
            guard let pass = (self.source as? PassViewFromProtocol)?.passView else {
                print("Need Called setView")
                return
            }
            guard let passContainer = (toVC as? PassViewToProtocol)?.containerView else {
                print("Need implement PassViewToProtocol")
                return
            }
            if let c = self.config as? PassViewPushConfig {
                c.pass = pass
                c.passOriginalSuper = pass.superview
                pass.superview?.isHidden = true
            }
            (toVC as? PassViewToProtocol)?.transitionWillStart(passView: pass)
            let convertRect:CGRect = pass.superview?.convert(pass.superview!.frame, to: nil) ?? .zero
            let finalFrame = transitionContext.finalFrame(for: toVC)
            let originalColor = toVC.view.backgroundColor
            toVC.view.backgroundColor = UIColor.clear
            toVC.view.frame = finalFrame
            toVC.view.addSubview(pass)
            toVC.view.layoutIfNeeded()
            pass.frame = convertRect
            self.animate(animations: {
                pass.frame = passContainer.frame
            }, completion: { (finish) in
                passContainer.addSubview(pass)
                toVC.view.backgroundColor = originalColor
                (toVC as? PassViewToProtocol)?.transitionCompleted(passView: pass)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        case .pop:
            let from = transitionContext.viewController(forKey: .from)
            guard let config = self.config as? PassViewPushConfig else {
                return
            }
            
            guard let pass = config.pass , let superV = config.passOriginalSuper  else {
                return
            }
            
            guard let source = (self.source as? PassViewFromProtocol) else {
                print("Need Implement PassViewFromProtocol")
                return
            }
            from?.view.alpha = 0.0
            let convertRect:CGRect = superV.convert(superV.frame, to: nil)
            container.addSubview(pass)
            container.layoutIfNeeded()
            from?.view.backgroundColor = UIColor.clear
            self.animate(animations: {
                pass.frame = convertRect
            }, completion: { (finish) in
                config.passOriginalSuper?.addSubview(pass)
                source.completed(passView: pass, superV: superV)
                superV.isHidden = false
                from?.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })            
        default:
            break
        }
    }
}
