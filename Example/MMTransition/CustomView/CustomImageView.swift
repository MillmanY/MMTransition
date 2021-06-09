//
//  CustomImageView.swift
//  MMTransition_Example
//
//  Created by Millman on 2019/3/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MMTransition
class CustomImageView: UIImageView {
}

extension CustomImageView: ContainerViewProtocol {
    func containerViewWith(status: TransitionToStatus) {
        switch status {
        case .willCome, .leave:
            self.alpha = 0.0
        case .come, .willLeave:
            self.alpha = 1.0
        case .setContainerWith(let view):
            if let v = view as? UIImageView {
                self.image = v.image
            }
        }
    }
}

extension CustomImageView: PassViewProtocol {
    func passWith(status: TransitionFromStatus) {
        switch status {
        case .willLeave:
            self.alpha = 1.0
        case .back:
            self.alpha = 1.0
        case .willBack:
            self.alpha = 0.0
        case .leave:
            self.alpha = 0.0
            self.translatesAutoresizingMaskIntoConstraints = false
            self.resetPassViewLayout()
            
        }
    }
    
    func resetPassViewLayout() {
//        self.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    
    }
}

