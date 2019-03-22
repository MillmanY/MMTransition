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
            toVC.view.layoutIfNeeded()
            
            guard let from = transitionContext.viewController(forKey: .from),
                let fromProtocol = from.fromProtocolVC else {
                    print("From protocol not found")
                    transitionContext.completeTransition(true)
                    return
            }
            
            guard let toProtocol = toVC.toProtocolVC else {
                print("To Protocol not found")
                transitionContext.completeTransition(true)
                return
            }
            
            let passView = fromProtocol.passView
            let passContainer = toProtocol.containerView
            
            if let c = self.config as? PassViewPushConfig {
                c.passOriginalSuper = passView.superview
                c.pass = passView
            }
            fromProtocol.transitionWillStart()
            let convertFrom: CGRect = passView.superview?.convert(passView.frame, to: nil) ?? .zero
            let convertTo = passContainer.superview?.convert(passContainer.frame, to: container) ?? .zero
            let finalFrame = transitionContext.finalFrame(for: toVC)
            let originalColor = toVC.view.backgroundColor
            toVC.view.backgroundColor = UIColor.clear
            toVC.view.frame = finalFrame
            container.addSubview(passView)
            container.layoutIfNeeded()
            passView.frame = convertFrom
            
            UIView.animate(withDuration: self.config.duration, animations: {
                passView.frame = convertTo
            }, completion: { (finish) in
                passView.translatesAutoresizingMaskIntoConstraints = false
                toVC.view.backgroundColor = originalColor
                passContainer.addSubview(passView)
                toProtocol.transitionCompleted(view: passView)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        case .pop:
            let from = transitionContext.viewController(forKey: .from)
            
            guard let config = self.config as? PassViewPushConfig else {
                transitionContext.completeTransition(true)
                return
            }
            
            guard let pass = config.pass else {
                transitionContext.completeTransition(true)
                return
            }
            
            guard let to = transitionContext.viewController(forKey: .to),
                let source =  to.fromProtocolVC  else {
                    transitionContext.completeTransition(true)
                    print("Need Implement PassViewFromProtocol")
                    return
            }

            guard let superV = source.backReplaceSuperView?(original: config.passOriginalSuper) ?? config.passOriginalSuper else {
                pass.translatesAutoresizingMaskIntoConstraints = false
                source.completed(passView: pass, superV: nil)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                source.transitionCompleted()
                return
            }
            pass.translatesAutoresizingMaskIntoConstraints = true
            let original: CGRect = pass.convert(pass.frame, to: nil)
            let convertRect: CGRect = superV.superview?.convert(superV.frame, to: to.view) ?? .zero
            pass.removeFromSuperview()
            container.addSubview(pass)
            pass.frame = original
            UIView.animate(withDuration: self.config.duration, animations: {
                from?.view.alpha = 0.0
                pass.frame = convertRect
            }, completion: { (finish) in
                pass.translatesAutoresizingMaskIntoConstraints = false
                superV.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                superV.addSubview(pass)
                source.completed(passView: pass, superV: superV)
                source.transitionCompleted()
            })
        default:
            break
        }
    }
}
