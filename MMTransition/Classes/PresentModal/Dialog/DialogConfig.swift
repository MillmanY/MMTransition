//
//  DialogConfig.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit

public enum DialogType {
    case preferSize //Xib use
    case size(s:CGSize) //Custom Size
}

public enum DirectionType {
    case left
    case right
    case top
    case bottom
}

public enum DialogAnimateType {
    case alpha(from:CGFloat , to:CGFloat)
    case scale(from:CGFloat , to:CGFloat)
    case direction(type:DirectionType)
}

public class DialogConfig: NSObject , PresentConfig {
    public var isShowMask: Bool = true
    public var presentingScale:CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption:UIViewAnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration:TimeInterval = 0.3

    public var dialogType:DialogType = DialogType.size(s: CGSize(width: 100, height: 100))
    public var animateType:DialogAnimateType = .alpha(from: 0, to: 1)
    public var presentView:(opacity: CGFloat ,radius: CGFloat) = (0.0 , 0.0)
    
}
