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
    
    var maskColor: UIColor {get set}
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


@objc public protocol MMTransitionFromBaseProtocol {
    @objc optional func backReplaceSuperView(original: UIView?) -> UIView?
    @objc optional func willPassView() -> Bool
}



public protocol MMTransitionFromProtocol: MMTransitionFromBaseProtocol {
    var pass: (view: UIView, delegate: PassViewProtocol)? { get }
//    func passErrorWitN()
//    func transitionFrom(status: TransitionFromStatus)
}

public protocol MMTransitionToProtocol {
    var container: (view: UIView, delegate: ContainerViewProtocol)? { get }
//    func transitionTo(status: TransitionToStatus)
}

public enum TransitionFromStatus {
    case willLeave
    case leave
    case willBack
    case back
}

public enum TransitionToStatus {
    case willCome
    case come
    case setContainerWith(view: UIView)
    case willLeave
    case leave
}

public protocol PassViewProtocol {
    func passWith(status: TransitionFromStatus)
    func resetPassViewLayout()
}

public protocol ContainerViewProtocol {
    func containerViewWith(status: TransitionToStatus)
}



