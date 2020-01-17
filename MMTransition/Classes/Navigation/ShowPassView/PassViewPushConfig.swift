//
//  PassViewPushConfig.swift
//  ETNews
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit

public class PassViewPushConfig: NSObject ,NavConfig {
    weak public var passOriginalSuper: UIView?
    weak public var pass: UIView?
    
    public var dismissTapMask: Bool = false
    public var maskColor = UIColor.black.withAlphaComponent(0.5)
    public var presentingScale:CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption:UIView.AnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration:TimeInterval = 0.3
}
