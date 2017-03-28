//
//  MenuPresentationController.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit

class MenuPresentationController: BasePresentationController {
    public override var frameOfPresentedViewInContainerView: CGRect {
        
        get {
            if let frame = containerView?.frame {
                let width = frame.width
                let height = frame.height
                switch (config as! MenuConfig).dialogType {
                case .bottomHeight(let h):
                    let y = height - h
                    return CGRect(x: 0, y: y, width: width, height: h)
                case .bottomHeightFromViewRate(let rate):
                    let rateH = height * rate
                    let y = height - rateH
                    return CGRect(x: 0, y: y, width: width, height: rateH)
                case .leftWidth(let w):
                    return CGRect(x: 0, y: 0, width: w, height: height)
                case .leftWidthFromViewRate(let rate):
                    let rateW = rate * width
                    return CGRect(x: 0, y: 0, width: rateW, height: height)
                case .rightWidth(let w):
                    return CGRect(x: width - w, y: 0, width: w, height: height)
                case .rightWidthFromViewRate(let rate):
                    let rateW = rate * width
                    return CGRect(x: width - rateW , y: 0, width: rateW, height: height)
                case .leftFullScreen , .rightFullScreen:
                    return CGRect(x: 0, y: 0, width: width, height: height)
                }
            } else if let f = self.presentedView?.frame {
                return f
            }
            
            return CGRect.zero
        } set {}
    }
}
