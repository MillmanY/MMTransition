//
//  MMPresentAnimator.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/25.
//
//

import UIKit

public class MMPresentAnimator: NSObject , UIViewControllerTransitioningDelegate{
    public typealias T = PresentConfig
    public var config:T?
    
    internal let base:UIViewController
    
    public init(_ base: UIViewController) {
        self.base = base
        super.init()
        base.modalPresentationStyle = .custom
        base.transitioningDelegate = self
        
    }
    
    public func dialog<T: DialogConfig>(setting: (_ config: T)->Void ) {
        config = DialogConfig()
        setting(self.config! as! T)
    }
    
    public func menu<T: MenuConfig >(setting: (_ config: T)->Void ) {
        self.config = MenuConfig()
        setting(self.config! as! T)
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let c = config {
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
        return self.transition(config: config, isPresent: false)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition(config: config, isPresent: true)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self.presentationController(config: config, forPresented: presented, presenting: presenting)
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
