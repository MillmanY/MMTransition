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
            guard let from = transitionContext.viewController(forKey: .from),
                  let pass = self.findFromVCWithProtocol(vc: from)?.passView else {
                print("Need Called setView")
                return
            }
            guard let passContainer = (transitionContext.viewController(forKey: .to) as? PassViewToProtocol)?.containerView else {
                print("Need Called setView")
                return
            }

            if let c = self.config as? PassViewPushConfig {
                c.pass = pass
                c.passOriginalSuper = pass.superview
                pass.superview?.isHidden = true
            }
            (toVC as? PassViewToProtocol)?.transitionWillStart(passView: pass)
            pass.translatesAutoresizingMaskIntoConstraints = true
            let convertRect:CGRect = pass.superview?.convert(pass.superview!.frame, to: nil) ?? .zero
            let finalFrame = transitionContext.finalFrame(for: toVC)
            let originalColor = toVC.view.backgroundColor
           
            toVC.view.backgroundColor = UIColor.clear
            toVC.view.frame = finalFrame
            container.addSubview(pass)
            container.layoutIfNeeded()
            pass.frame = convertRect
            UIView.animate(withDuration: self.config.duration, animations: {
                pass.frame = passContainer.frame

            }, completion: { (finish) in
                pass.frame = passContainer.frame
                passContainer.addSubview(pass)
                toVC.view.backgroundColor = originalColor
                pass.translatesAutoresizingMaskIntoConstraints = false
                (toVC as? PassViewToProtocol)?.transitionCompleted(passView: pass)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        case .pop:
            let from = transitionContext.viewController(forKey: .from)
            guard let config = self.config as? PassViewPushConfig else {
                return
            }
            
            guard let pass = config.pass else {
                return
            }
            
            
            guard let to = transitionContext.viewController(forKey: .to),
                  let source =  self.findFromVCWithProtocol(vc: to)  else {
                    print("Need Implement PassViewFromProtocol")
                    return
            }
            
            let superV = source.backReplaceSuperView?(original: config.passOriginalSuper) ?? config.passOriginalSuper
            let original:CGRect = pass.superview?.convert(pass.superview!.frame, to: nil) ?? .zero

            let convertRect:CGRect = (superV != nil ) ? superV!.convert(superV!.frame, to: nil) : .zero
            
            if superV != nil {
                container.addSubview(pass)
            }
            pass.translatesAutoresizingMaskIntoConstraints = true

            container.layoutIfNeeded()
            pass.frame = original
            UIView.animate(withDuration: self.config.duration, animations: {
                from?.view.alpha = 0.0
                pass.frame = convertRect
            }, completion: { (finish) in
                superV?.addSubview(pass)
                pass.translatesAutoresizingMaskIntoConstraints = false
                source.completed(passView: pass, superV: superV)
                superV?.isHidden = false
                from?.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
        default:
            break
        }
    }

    
    func findFromVCWithProtocol(vc: UIViewController) -> (PassViewFromProtocol & UIViewController)? {
        if let pass = vc as? PassViewFromProtocol & UIViewController , pass.willPassView?() ?? true {
            return pass
        } else if let first = vc.childViewControllers.first(where: { self.findFromVCWithProtocol(vc: $0) != nil }) as? PassViewFromProtocol & UIViewController {
            return first
        }
        return nil
    }
}
