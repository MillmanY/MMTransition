//
//  MMPushAnimator.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/25.
//
//

import UIKit

public typealias T = NavConfig
public class MMPushAnimator: NSObject , UINavigationControllerDelegate {
    public var config:T?
    unowned let base:UIViewController
    var transition: UIViewControllerAnimatedTransitioning?

    public init(_ base: UIViewController) {
        self.base = base
        super.init()
        base.navigationController?.delegate = self
    }

    public func alpha<T: AlphaConfig>(setting: (_ config: T)->Void ) {
        config = AlphaConfig()
        self.transition = nil
        setting(self.config! as! T)
    }
    
    public func pass<T: PassViewPushConfig>(setting: (_ config: T)->Void) {
        self.config = PassViewPushConfig()
        self.transition = nil
        setting(self.config! as! T)
    }

    public func removeAnimate() {
        self.config = nil
        self.transition = nil
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        if let c = config , transition == nil {
            switch c {
            case let c as AlphaConfig:
                transition = AlphaTransition(config: c, operation: operation)
            case let c as PassViewPushConfig:
                let t = PassViewPushTransition(config: c, operation: operation)
                t.source = self.base
                transition = t
            default:
                break
            }
        }
        if let t = self.transition as? BaseNavTransition {
            t.operation = operation
        }
        
        return transition
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
