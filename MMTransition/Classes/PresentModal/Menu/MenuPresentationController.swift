//
//  MenuPresentationController.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/28.
//
//

import UIKit

public class MenuPresentationController: BasePresentationController {
    var originFrame: CGRect = .zero
    var typeObserver: Any?
    public var firstOffset:CGPoint = .zero
    public var percent: CGFloat = 0.01
    fileprivate var pan: UIPanGestureRecognizer?
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(MenuPresentationController.pan(gesture:)))
        originFrame = self.containerView?.frame ?? .zero
        self.update(type: (config as? MenuConfig)?.menuType, animated: false)
    }
    
    public func update(type: MenuType?, animated: Bool = true, completed: (()->Void)? = nil) {
        
        guard let t = type else {
            return
        }
       (config as? MenuConfig)?.menuType = t
        let view  = (config as? MenuConfig)?.isContainerFullScreen == false ? containerView : self.presentedView
        var frame = CGRect.zero
        if let menu = config as? MenuConfig, menu.isContainerFullScreen == false {
            frame = self.calculatePresentFrame(isFull: false)
        } else {
            frame = originFrame
        }
        
        if animated {
            self.setHidden(true, animated: false)
            UIView.animate(withDuration: config.duration, animations: {
                view?.frame = frame
            }, completion: { (finish) in
                completed?()
            })
        } else {
            view?.frame = frame
            completed?()
        }
    }
    
    public func setHidden(_ isHidden: Bool, animated: Bool) {
        let view  = (config as? MenuConfig)?.isContainerFullScreen == false ? containerView : self.presentedView

        let frame = self.calculatePresentFrame(isFull: (config as? MenuConfig)?.isContainerFullScreen ?? true, isHidden: isHidden)
       
        if animated {
            UIView.animate(withDuration: config.duration) {
                view?.frame = frame
            }
        } else {
            view?.frame = frame
        }
        
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        
        get {
            return self.calculatePresentFrame()
        } set {}
    }
    
    func calculatePresentFrame(isFull: Bool = true, isHidden: Bool = false) -> CGRect {
        if let frame = isFull ? containerView?.frame : UIScreen.main.bounds {
            let width = frame.width
            let height = frame.height
            switch (config as! MenuConfig).menuType {
            case .bottomHeight(let h):
                let y = isHidden ? height : height - h
                return CGRect(x: 0, y: y, width: width, height: h)
            case .bottomHeightFromViewRate(let rate):
                let rateH = height * rate
                let y = isHidden ? height : height - rateH
                return CGRect(x: 0, y: y, width: width, height: rateH)
            case .leftWidth(let w):
                return CGRect(x: isHidden ? -w : 0, y: 0, width: w, height: height)
            case .leftWidthFromViewRate(let rate):
                let rateW = rate * width
                return CGRect(x: isHidden ? -rateW : 0, y: 0, width: rateW, height: height)
            case .rightWidth(let w):
                return CGRect(x: isHidden ? width : width - w, y: 0, width: w, height: height)
            case .rightWidthFromViewRate(let rate):
                let rateW = rate * width
                return CGRect(x: isHidden ? width : width - rateW , y: 0, width: rateW, height: height)
            case .leftFullScreen:
                return CGRect(x: isHidden ? -width : 0, y: 0, width: width, height: height)
            case .rightFullScreen:
                return CGRect(x: isHidden ? width : 0, y: 0, width: width, height: height)
            case .topFullScreen(let margin):
                return CGRect(x: 0, y: 0, width: width, height: height-margin)
            case .top(let h, _):
                return CGRect.init(x: 0, y: 0, width: width, height: h)
            }
        } else if let f = self.presentedView?.frame {
            return f
        }
        return .zero
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }
    
    @objc func pan(gesture:UIPanGestureRecognizer) {
        if let c = config as? MenuConfig , c.isDraggable  {
            let view = self.presentedViewController.view
            switch gesture.state {
            case .began:
                c.drivenInteractive = UIPercentDrivenInteractiveTransition()
                firstOffset = gesture.translation(in: view)
                self.presentedViewController.dismiss(animated: true, completion: nil)
            case .changed:
                let current = gesture.translation(in: view)
                let percent = self.calculatePercent(offset: current, config: c)
                self.presentingViewScale(percent: percent, animate: false)
                c.drivenInteractive?.update(percent)
            case .ended, .cancelled :
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
    
    fileprivate func presentingViewScale(percent: CGFloat, animate: Bool) {
        self.percent = percent
        let fix = (CGFloat(1.0) - config.presentingScale) * percent + config.presentingScale
        if fix >= config.presentingScale {
            if animate {
                UIView.animate(withDuration: 0.1, animations: { [weak self] in
                    self?.presentingViewController.view.transform = CGAffineTransform(scaleX: fix, y: fix)
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
            case .topFullScreen, .top(_,_):
                percent =  (offset.y - firstOffset.y) / (view.frame.height + 1)
            case .bottomHeight(_) , .bottomHeightFromViewRate(_):
                percent =  (offset.y - firstOffset.y) / (view.frame.height + 1)
            case .rightWidth(_) , .rightWidthFromViewRate(_) , .rightFullScreen:
                percent = (offset.x - firstOffset.x) / (view.frame.width + 1)
            case .leftWidth(_) , .leftWidthFromViewRate(_) , .leftFullScreen:
                percent = (firstOffset.x - offset.x) / (view.frame.width + 1)
            
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
    
    deinit {
        
    }
}
