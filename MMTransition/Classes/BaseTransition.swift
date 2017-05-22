//
//  BaseTransition.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit

public class BasePresentTransition: NSObject {
    var isPresent = true
    var source: UIViewController?
    internal var config: PresentConfig!

    convenience init(config: PresentConfig , isPresent: Bool) {
        self.init()
        self.config = config
        self.isPresent = isPresent
    }

    func animate(animations: @escaping () -> Void , completion:((Bool) -> Void)?) {
        
        if config.damping == 0.0 {
            UIView.animate(withDuration: config.duration, animations: animations, completion: completion)
        } else {
            UIView.animate(withDuration: config.duration, delay: 0.0, usingSpringWithDamping: config.damping, initialSpringVelocity: config.springVelocity, options: config.animationOption, animations: animations, completion: completion)
        }
    }
}


public class BaseNavTransition: NSObject {
    var operation:UINavigationControllerOperation = .none
    var source: UIViewController?
    internal var config:NavConfig!
    
    convenience init(config: NavConfig , operation: UINavigationControllerOperation) {
        self.init()
        self.config = config
        self.operation = operation
    }
    
    func animate(animations: @escaping () -> Void , completion:((Bool) -> Void)?) {
        
        if config.damping == 0.0 {
            UIView.animate(withDuration: config.duration, animations: animations, completion: completion)
        } else {
            UIView.animate(withDuration: config.duration, delay: 0.0, usingSpringWithDamping: config.damping, initialSpringVelocity: config.springVelocity, options: config.animationOption, animations: animations, completion: completion)
        }
    }
}

