//
//  PassViewPushConfig.swift
//  ETNews
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit

public class PassViewPushConfig: NSObject ,NavConfig {
    weak var passOriginalSuper: UIView?
    weak var pass: UIView?
    
    public var isShowMask: Bool = true
    public var presentingScale:CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption:UIViewAnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration:TimeInterval = 0.3
}
