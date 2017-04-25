//
//  MMTransition.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/24.
//
//

import UIKit


public protocol Config {
    var isShowMask:Bool {get set}
    var damping : CGFloat { get set }
    var springVelocity : CGFloat { get set }
    var animationOption:UIViewAnimationOptions { get set }
    var duration : TimeInterval { get set }
}

public protocol PresentConfig: Config {
    var presentingScale:CGFloat  { get set }
    var presentView:(opacity: CGFloat ,radius: CGFloat) {get set}
}

public protocol NavConfig: Config {
}

public protocol TransitionCompatible {
    associatedtype CompatibleType
    static var mmT: MMTransition<CompatibleType>.Type { get set }
    
    var mmT: MMTransition<CompatibleType> { get set }
}

extension TransitionCompatible {
    public static var mmT: MMTransition<Self>.Type {
        get {
            return MMTransition<Self>.self
        } set {}
    }
    
    public var mmT: MMTransition<Self> {
        get {
            return MMTransition(self)
        } set {}
    }
}

public struct MMTransition<T> {
    public let base:T
    init(_ base: T) {
        self.base = base
    }
}


extension NSObject: TransitionCompatible { }

fileprivate var mmPresentKey = "MMPresentKey"
fileprivate var mmPushKey = "MMPushKey"
public extension MMTransition where T: UIViewController {

    var present:MMPresentAnimator {
        
        if let v = objc_getAssociatedObject(base, &mmPresentKey) {
            return v as! MMPresentAnimator
        }
        let m = MMPresentAnimator(self.base)
        objc_setAssociatedObject(base, &mmPresentKey, m, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return m
    }
}

public extension MMTransition where T: UINavigationController {
    var push:MMPushAnimator {
        
        if let v = objc_getAssociatedObject(base, &mmPushKey) {
            return v as! MMPushAnimator
        }
        let m = MMPushAnimator(self.base)
        objc_setAssociatedObject(base, &mmPushKey, m, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return m
    }
}

