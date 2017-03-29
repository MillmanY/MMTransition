//
//  MMAnimator.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit
public class MMAnimator<T:NSObject where T:Config>: NSObject , UIViewControllerTransitioningDelegate {
    var animatorConfig:T?
    
    public override init() {
        animatorConfig = T()
    }
    
    public func activity(setting:(_ config:T)->Void) {
        if let c = animatorConfig {
            setting(c)
        }
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let c = animatorConfig , animator != nil{
            switch c {
            case let c as MenuConfig:
                return c.drivenInteractive
            default:
               break
            }
        }
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition(config: animatorConfig, isPresent: false)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition(config: animatorConfig, isPresent: true)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self.presentationController(config: animatorConfig, forPresented: presented, presenting: presenting)
    }
    
    fileprivate func transition(config:T? ,isPresent:Bool) -> UIViewControllerAnimatedTransitioning? {
       
        if let c = config {
            switch c {
            case let c as DialogConfig:
                return DialogTransition(config: c, isPresent: isPresent)
            case let c as MenuConfig:
                return MenuTransition(config: c, isPresent: isPresent)
            default: break
            }
        }
        return nil
    }
    
    fileprivate func presentationController(config:T? , forPresented presented: UIViewController, presenting: UIViewController?) -> UIPresentationController? {
        
        if let c = config {
            switch c {
            case let c as DialogConfig:
                return DialogPresentationController(presentedViewController: presented, presenting: presenting, config: c)
            case let c as MenuConfig:
                return MenuPresentationController(presentedViewController: presented, presenting: presenting, config: c)
            default: break
            }
        }
        
        return nil
    }
}
