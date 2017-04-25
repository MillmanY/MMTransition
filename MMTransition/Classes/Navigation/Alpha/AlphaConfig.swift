//
//  AlphaConfig.swift
//  ETNews
//
//  Created by Millman YANG on 2017/4/24.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit

public class AlphaConfig: NSObject , NavConfig {
    public var isShowMask: Bool = true
    public var damping: CGFloat = 0.0
    public var animationOption:UIViewAnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration:TimeInterval = 0.3
    var navigationDelegate:UINavigationController?

}
