//
//  UIView+Shape.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/25.
//
//

import Foundation
import UIKit

var ShapeKey = "ShapeKey"

extension UIView {
    
    var mShape:TransitionShape {
        set {
            objc_setAssociatedObject(self, &ShapeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            if let mShape = objc_getAssociatedObject(self, &ShapeKey) as? TransitionShape {
                return mShape
            } else {
                self.mShape = TransitionShape(view: self)
                return self.mShape
            }
        }
    }
}

class TransitionShape: NSObject {
    
    internal let view: UIView
    internal init(view: UIView) {
        self.view = view
    }
    
    func shadow(opacity: Float, radius: Float) {
        self.view.layer.shadowColor   = UIColor.black.cgColor
        self.view.layer.shadowOpacity = opacity
        self.view.layer.shadowRadius  = CGFloat(radius)
    }
}
