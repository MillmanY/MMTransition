//
//  CenterDialog.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit

public class DialogTransition: BasePresentTransition , UIViewControllerAnimatedTransitioning {
            
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch (config as! DialogConfig).animateType {
        case .alpha(let from,let to):
            self.animateAlpha(from: from, to: to, context: transitionContext)
        case .scale(let from,let to):
            self.animateScale(from: from, to: to, context: transitionContext)
        case .direction(let type):
            self.direction(type: type, context: transitionContext)
        }
    }
    
    func direction(type:DirectionType , context:UIViewControllerContextTransitioning) {
        let container = context.containerView
        if self.isPresent {
            let toVC = context.viewController(forKey: .to)!
            let finalFrame = context.finalFrame(for: toVC)
            toVC.view.frame = finalFrame  
            toVC.view.transform = self.direction(type: type, frame: container.frame)
            
            container.addSubview(toVC.view)
        
            self.animate(animations: {
                toVC.view.transform = .identity
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
            
        } else {
            let fromView = context.viewController(forKey: .from)!
            
            self.animate(animations: {
                fromView.view.transform = self.direction(type: type, frame: container.frame)
            }, completion: { (finish) in
                fromView.view.transform = .identity
                context.completeTransition(!context.transitionWasCancelled)
            })
        }
    }
    
    fileprivate func direction(type:DirectionType,frame:CGRect) -> CGAffineTransform {
        let width = frame.width
        let height = frame.height
        switch type {
        case .left:
             return CGAffineTransform(translationX: -width, y: 0)
        case .right:
             return CGAffineTransform(translationX: width, y: 0)
        case .top:
            return CGAffineTransform(translationX: 0, y: -height)
        case .bottom:
            return CGAffineTransform(translationX: 0, y: height)
        }
    }
    
    func animateScale(from: CGFloat ,to: CGFloat,context:UIViewControllerContextTransitioning) {
        let container = context.containerView
        if self.isPresent {
            
            let toVC = context.viewController(forKey: .to)!
            let finalFrame = context.finalFrame(for: toVC)
            toVC.view.frame = finalFrame
            toVC.view.transform = CGAffineTransform.init(scaleX: 0.00001, y: 0.0001)
            container.addSubview(toVC.view)
            
            self.animate(animations: {
                toVC.view.transform = .identity
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
            
        } else {
            let fromView = context.viewController(forKey: .from)!
            
            self.animate(animations: {
                fromView.view.transform = CGAffineTransform.init(scaleX: 0.00001, y: 0.0001)
            }, completion: { (finish) in
                fromView.view.transform = .identity
                context.completeTransition(!context.transitionWasCancelled)
            })
        }

    }
    
    func animateAlpha(from: CGFloat ,to: CGFloat,context:UIViewControllerContextTransitioning) {
        let container = context.containerView
        if self.isPresent {
            let toVC = context.viewController(forKey: .to)!
            let finalFrame = context.finalFrame(for: toVC)
            container.addSubview(toVC.view)
            toVC.view.frame = finalFrame
            toVC.view.alpha = from
            self.animate(animations: {
                toVC.view.alpha = to
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
            
        } else {
            let fromView = context.viewController(forKey: .from)!
            
            self.animate(animations: {
                fromView.view.alpha = from
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
        }
    }
}



