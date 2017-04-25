//
//  CenterDialogPresentationController.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit
public class DialogPresentationController: BasePresentationController {
    
    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.presentingViewController.view.transform = .identity
        }, completion: nil)
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        
        get {
            if let frame = containerView?.frame {
                let width = frame.width
                let height = frame.height
                switch (config as! DialogConfig).dialogType {
                case .preferSize:
                    let presentedSize = self.presentedViewController.preferredContentSize
                    return CGRect(x: (width - presentedSize.width) / 2,
                                  y: (height - presentedSize.height) / 2,
                                  width: presentedSize.width,
                                  height: presentedSize.height)
                case .size(let s):
                    return CGRect(x: (width - s.width) / 2,
                                  y: (height - s.height) / 2,
                                  width: s.width,
                                  height: s.height)
                }
            } else if let f = self.presentedView?.frame {
                return f
            }
            
            return CGRect.zero
        } set {}
    }
}
