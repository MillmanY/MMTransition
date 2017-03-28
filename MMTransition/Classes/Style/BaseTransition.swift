//
//  BaseTransition.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit

public class BaseTransition: NSObject {
    var isPresent = true
    internal var config:Config!

    convenience init(config:Config , isPresent:Bool) {
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
