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

public class DialogConfig: BaseConfig {
    public var dialogType:DialogType = DialogType.size(s: CGSize(width: 100, height: 100))
    public var animateType:DialogAnimateType = .alpha(from: 0, to: 1)
}
