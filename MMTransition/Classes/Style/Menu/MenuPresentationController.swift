//
//  MenuPresentationController.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit

public class MenuPresentationController: BasePresentationController {
    public var firstOffset:CGPoint = .zero
    public var percent:CGFloat = 0.01
    fileprivate var pan:UIPanGestureRecognizer?
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(MenuPresentationController.pan(gesture:)))
        self.presentedView?.addGestureRecognizer(pan!)
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        
        get {
            if let frame = containerView?.frame {
                let width = frame.width
                let height = frame.height
                switch (config as! MenuConfig).menuType {
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
    
    func pan(gesture:UIPanGestureRecognizer) {
        if let c = config as? MenuConfig , c.isDraggable  {
            let view = self.presentedViewController.view
            switch gesture.state {
            case .began:
                c.drivenInteractive = UIPercentDrivenInteractiveTransition()
                firstOffset = gesture.translation(in: view)
                self.presentedViewController.dismiss(animated: true, completion: nil)
            case .changed:
                let current = gesture.translation(in: view)
                let shift = current.y - firstOffset.y
                let percent = self.calculatePercent(offset: current, config: c)
                self.presentingViewScale(percent: percent, animate: false)
                c.drivenInteractive?.update(percent)
            case .ended , .cancelled :
                let currentPercent = c.drivenInteractive?.percentComplete ?? 0.0
                
                if c.draggableCompletedPrecent < currentPercent {
                    c.drivenInteractive?.finish()
                } else {
                    self.presentingViewScale(percent: 0.01, animate: true)
                    c.drivenInteractive?.cancel()
                }
                c.drivenInteractive = nil
            default:
                break
            }
        } else {
            percent = 0.001
            if let c = config as? MenuConfig {
                c.drivenInteractive?.cancel()
                c.drivenInteractive = nil
            }
        }
    }
    
    fileprivate func presentingViewScale(percent:CGFloat , animate:Bool) {
        self.percent = percent
        let fix =  (CGFloat(1.0) - config.presentingScale) * percent + config.presentingScale
        if fix >= config.presentingScale {
            //                print(self.presentingViewController.view.transform.d)
            if animate {
                UIView.animate(withDuration: 0.1, animations: { 
                    self.presentingViewController.view.transform = CGAffineTransform(scaleX: fix, y: fix)
                })
            } else {
                self.presentingViewController.view.transform = CGAffineTransform(scaleX: fix, y: fix)
            }
        }

    }
    
    fileprivate func calculatePercent (offset:CGPoint , config:MenuConfig) -> CGFloat {
        var percent:CGFloat = 0.001
        if let view = presentedViewController.view {
            switch config.menuType {
            case .bottomHeight(_) , .bottomHeightFromViewRate(_):
                percent =  (offset.y - firstOffset.y) / (view.frame.height + 1)
            case .rightWidth(_) , .rightWidthFromViewRate(_) , .rightFullScreen:
                percent = (offset.x - firstOffset.x) / (view.frame.width + 1)
            case .leftWidth(_) , .leftWidthFromViewRate(_) , .leftFullScreen:
                percent = (firstOffset.x - offset.x) / (view.frame.width + 1)
            default:break
            }
        }
        if percent <= 0 {
            return 0.001
        } else if percent >= 1 {
            return 0.99
        } else {
            return percent
        }
    }
}
