//
//  PassViewConfig.swift
//  ETNews
//
//  Created by Millman YANG on 2017/5/16.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit

public class PassViewPresentConfig: NSObject ,PresentConfig {
    public var shouldApperancePresentingController: Bool = true
    
    weak var passOriginalSuper: UIView?
    weak var pass: UIView?
    
    public var dismissTapMask: Bool = false
    public var isShowMask: Bool = true
    public var presentingScale:CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption:UIViewAnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration:TimeInterval = 0.3    
    public var presentView:(opacity: CGFloat ,radius: CGFloat) = (0.0 , 0.0)
}
