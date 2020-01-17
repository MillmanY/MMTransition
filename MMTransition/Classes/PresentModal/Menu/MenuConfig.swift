//
//  MenuConfig.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit
public enum MenuType {
    case leftWidth(w: CGFloat)
    case leftWidthFromViewRate(rate: CGFloat)
    
    case rightWidth(w: CGFloat)
    case rightWidthFromViewRate(rate: CGFloat)
    
    case bottomHeight(h: CGFloat)
    case bottomHeightFromViewRate(rate: CGFloat)
    
    case topFullScreen(margin: CGFloat)
    case top(h: CGFloat, margin: CGFloat)
    case leftFullScreen
    case rightFullScreen
}

public class MenuConfig: NSObject, PresentConfig {
    public var source: UIViewController?
    
    public var shouldApperancePresentingController: Bool = true
    public var isContainerFullScreen = true
    public var maskColor = UIColor.black.withAlphaComponent(0.5)
    public var dismissTapMask: Bool = false
    public var presentingScale: CGFloat = 1.0
    public var damping: CGFloat = 0.0
    public var animationOption: UIView.AnimationOptions = .curveLinear
    public var springVelocity: CGFloat = 0.0
    public var duration: TimeInterval = 0.3

    public var menuType: MenuType = .bottomHeight(h: 100)
    public var isDraggable = false
    public var drivenInteractive: UIPercentDrivenInteractiveTransition?
    public var draggableCompletedPrecent: CGFloat = 0.5
    
    public var presentView: (opacity: CGFloat, radius: CGFloat) = (0.0, 0.0)
    
    public var modelPresentationStyle = UIModalPresentationStyle.custom
}
