//
//  TransitionDefine.swift
//  ETNews
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import Foundation

public protocol Config {
    var dismissTapMask: Bool {get set}
    var isShowMask: Bool {get set}
    var damping: CGFloat { get set }
    var springVelocity: CGFloat { get set }
    var animationOption: UIView.AnimationOptions { get set }
    var duration: TimeInterval { get set }
}

public protocol PresentConfig: Config {
    var source: UIViewController? { set get }
    var shouldApperancePresentingController: Bool { get set }
    var presentingScale: CGFloat  { get set }
    var presentView: (opacity: CGFloat,radius: CGFloat) {get set}
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
    public let base: T
    init(_ base: T) {
        self.base = base
    }
}

extension NSObject: TransitionCompatible { }

@objc public protocol MMTransitionFromProtocol {
    var passView: UIView { get }
    @objc optional func willPassView() -> Bool
    func transitionWillStart()
    func transitionCompleted()
    @objc optional func backReplaceSuperView(original: UIView?) -> UIView?
    @objc optional func presentedView(isShrinkVideo: Bool)
    @objc optional func dismissViewFromGesture()
    func completed(passView: UIView,superV: UIView?)

}

@objc public protocol MMTransitionToProtocol {
    var containerView: UIView { get }
    func transitionCompleted(view: UIView)
}
