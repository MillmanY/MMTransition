//
//  MMAnimatorDefine.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import Foundation

public protocol Config {
     var damping : CGFloat { get set }
     var springVelocity : CGFloat { get set }
     var animationOption:UIViewAnimationOptions { get set }
     var duration : TimeInterval { get set }
     var presentingScale:CGFloat  { get set }
}

public class BaseConfig:NSObject , Config {
    public var presentingScale:CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption:UIViewAnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var menuType:MenuType = .bottomHeight(h: 100)
    public var duration:TimeInterval = 0.3
    required override public init() {
        super.init()
    }
}

public enum DialogType {
    case preferSize //Xib use
    case size(s:CGSize) //Custom Size
}

public enum MMPresentationStyle {
    case dialog(type:DialogType)
}
