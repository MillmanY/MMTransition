//
//  MMPushAnimator.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/25.
//
//

import UIKit

//public typealias T = NavConfig
public class MMPushAnimator: NSObject , UINavigationControllerDelegate {
    public var config:NavConfig?
    unowned let base: UINavigationController
    var transition: UIViewControllerAnimatedTransitioning?
    lazy var _proxy: NavigationDelegateProxy = {
        return NavigationDelegateProxy(parent: self, forward: self.base.delegate)
    }()

    public init(_ base: UINavigationController) {
        self.base = base
        super.init()
    }
    
    public func alpha<T: AlphaConfig>(setting: (_ config: T)->Void ) {
        config = AlphaConfig()
        base.delegate = _proxy
        self.transition = nil
        setting(self.config! as! T)
    }
    
    public func pass<T: PassViewPushConfig>(setting: (_ config: T)->Void) {
        self.config = PassViewPushConfig()
        base.delegate = _proxy
        self.transition = nil
        setting(self.config! as! T)
    }
    
    public func removeAnimate() {
        self.config = nil
        self.transition = nil
        base.navigationController?.delegate = nil
    }
    
    public var enableCustomTransition: Bool = true {
        didSet {
            if enableCustomTransition {
                base.delegate = _proxy
            } else {
                base.navigationController?.delegate = nil
            }
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        

        
        if let proxy = self.base.delegate as? NavigationDelegateProxy,
            let childTransition = proxy.forward?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC) {
            return childTransition
        } else if self.enableCustomTransition == false {
            return nil
        }

        if let c = config , transition == nil {
            switch c {
            case let c as AlphaConfig:
                transition = AlphaTransition(config: c, operation: operation)
            case let c as PassViewPushConfig:
                let t = PassViewPushTransition(config: c, operation: operation)
                t.source = fromVC
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
