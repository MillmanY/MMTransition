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

public enum DialogType {
    case preferSize //Xib use
    case size(s:CGSize) //Custom Size
}

public enum MMPresentationStyle {
    case dialog(type:DialogType)
}
