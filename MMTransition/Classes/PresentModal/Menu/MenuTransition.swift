//
//  MenuTransition.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit

class MenuTransition: BasePresentTransition , UIViewControllerAnimatedTransitioning{
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        let container = transitionContext.containerView
        let height = container.frame.height
        let width = container.frame.width
        switch (config as! MenuConfig).menuType {
        case .bottomHeight(let h):
            self.bottom(context: transitionContext, height: h)
        case .bottomHeightFromViewRate(let rate):
            let rateH = height * rate
            self.bottom(context: transitionContext, height: rateH)
        case .leftWidth(let w):
            self.slide(context: transitionContext, width: w, params: 1)
        case .leftWidthFromViewRate(let rate):
            let rateW = rate * width
            self.slide(context: transitionContext, width: rateW, params: 1)
        case .rightWidth(let w):
            self.slide(context: transitionContext, width: w, params: -1)
        case .rightWidthFromViewRate(let rate):
            let rateW = rate * width
            self.slide(context: transitionContext, width: rateW, params: -1)
        case .leftFullScreen:
            self.slide(context: transitionContext, width: width, params: 1)
        case .rightFullScreen:
            self.slide(context: transitionContext, width: width, params: -1)
        }
    }
    
    func bottom(context:UIViewControllerContextTransitioning , height:CGFloat) {
        let container = context.containerView

        if self.isPresent {
            let toVC = context.viewController(forKey: .to)!
            let finalFrame = context.finalFrame(for: toVC)
            toVC.view.frame = finalFrame
            container.addSubview(toVC.view)
            toVC.view.transform = CGAffineTransform(translationX: 0, y: height)

            self.animate(animations: {
                toVC.view.transform = .identity
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
        } else {
            let fromView = context.viewController(forKey: .from)!
            self.animate(animations: {
                fromView.view.transform = CGAffineTransform(translationX: 0, y: height)
            }, completion: { (finish) in
                fromView.view.transform = .identity
                context.completeTransition(!context.transitionWasCancelled)
            })
        }
    }
    
    func slide(context:UIViewControllerContextTransitioning , width:CGFloat,params:CGFloat) {
        let container = context.containerView
        let x = -width * params
        if self.isPresent {
            let toVC = context.viewController(forKey: .to)!
            let finalFrame = context.finalFrame(for: toVC)
            toVC.view.frame = finalFrame
            container.addSubview(toVC.view)
            
            toVC.view.transform = CGAffineTransform(translationX: x, y: 0)
            
            self.animate(animations: {
                toVC.view.transform = .identity
                
            }, completion: { (finish) in
                context.completeTransition(!context.transitionWasCancelled)
            })
        } else {
            let fromView = context.viewController(forKey: .from)!
            self.animate(animations: {
                fromView.view.transform = CGAffineTransform(translationX: x, y: 0)
            }, completion: { (finish) in
                fromView.view.transform = .identity
                context.completeTransition(!context.transitionWasCancelled)
            })
        }
    }
}
