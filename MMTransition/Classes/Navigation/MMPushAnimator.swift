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
    
    internal let base:UIViewController

    public init(_ base: UINavigationController) {
        self.base = base
        super.init()
        base.delegate = self
    }

    public func alpha<T: AlphaConfig>(setting: (_ config: T)->Void ) {
        config = AlphaConfig()
        setting(self.config! as! T)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let c = config {
            switch c {
            case let c as AlphaConfig:
                return AlphaTransition(config: c, operation: operation)
            default:
                break
            }
        }
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
