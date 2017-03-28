//
//  BasePresentationController.swift
//  Pods
//
//  Created by Millman YANG on 2017/3/27.
//
//

import UIKit

public class BasePresentationController: UIPresentationController {
    internal var config:Config!
    public convenience init(presentedViewController: UIViewController, presenting
        presentingViewController: UIViewController? ,
                            config:Config) {
        
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.config = config
    }
    
    public var maskView:UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        if let c = containerView , maskView.superview == nil {
            c.addSubview(maskView)
        }

        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: self.config.presentingScale, y: self.config.presentingScale)
            self.maskView.alpha = 1.0
        }, completion: nil)

    }
    
    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.presentingViewController.view.transform = .identity
        }, completion: nil)
    }
    
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        maskView.removeFromSuperview()
    }
    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let c = containerView {
            maskView.frame = c.bounds
        }
    }
    
    public override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    public override var shouldRemovePresentersView: Bool {
        return false
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
       
            // Prevent Scale error
            if let c = self.containerView {
                self.presentingViewController.view.transform = .identity
                self.presentingViewController.view.frame = c.bounds
                self.presentingViewController.view.transform = CGAffineTransform(scaleX: self.config.presentingScale, y: self.config.presentingScale)
            }
            
            
            self.presentedViewController.view.frame = self.frameOfPresentedViewInContainerView
        }) { (context) in
        }
    }
}
