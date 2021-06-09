//
//  PassViewHelper.swift
//  MMTransition
//
//  Created by Millman on 2019/3/27.
//

import UIKit

public class PassViewHelper: NSObject {
    let transitionContext: UIViewControllerContextTransitioning
    var config: Config
    public init(transitionContext: UIViewControllerContextTransitioning, config: Config) {
        self.transitionContext = transitionContext
        self.config = config
    }
    
    public func goAction() {
        let container = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to)!
        container.addSubview(toVC.view)
        toVC.view.alpha = 0.0
        toVC.view.layoutIfNeeded()
        guard let from = transitionContext.viewController(forKey: .from),
            let fromProtocol = from.fromProtocolVC else {
                fatalError("MMTransitionFromProtocol not implement")
        }
        guard let toProtocol = toVC.toProtocolVC else {
            fatalError("MMTransitionToProtocol not implement")
        }
        
        
        fromProtocol.view.layoutIfNeeded()
        toProtocol.view.layoutIfNeeded()
        guard let (passView, passProtocol) = fromProtocol.pass,
             let (passContainer, containerProtocol) = toProtocol.container else {
                transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)
                return
        }
        let passOriginalSuper = passView.superview
        passProtocol.passWith(status: .willLeave)
        containerProtocol.containerViewWith(status: .willCome)
        
        let convertFrom: CGRect = passView.superview?.convert(passView.frame, to: nil) ?? .zero
        let convertTo = passContainer.superview?.convert(passContainer.frame, to: container) ?? .zero
        let finalFrame = transitionContext.finalFrame(for: toVC)
        passView.removeFromSuperview()
        passView.constraints.forEach { passView.removeConstraint($0) }
        passView.translatesAutoresizingMaskIntoConstraints = true
        
        
        toVC.view.frame = finalFrame
        container.addSubview(passView)
        container.layoutIfNeeded()
        passView.frame = convertFrom

        UIView.animate(withDuration: self.config.duration, animations: {
            passView.frame = convertTo
            toVC.view.alpha = 1.0
        }, completion: {(finish) in
            passProtocol.passWith(status: .leave)
            containerProtocol.containerViewWith(status: .come)
            containerProtocol.containerViewWith(status: .setContainerWith(view: passView))
            passOriginalSuper?.addSubview(passView)
            passProtocol.resetPassViewLayout()
            self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)
        })
    }
    
    public func backAction(isNavigation: Bool = false) {
        let container = transitionContext.containerView
        if isNavigation {
            let toVC = transitionContext.viewController(forKey: .to)!
            container.addSubview(toVC.view)
        }
        guard let to = transitionContext.viewController(forKey: .to),
            let source =  to.fromProtocolVC else {
                fatalError("MMTransitionFromProtocol not implement")
        }
        guard let f = transitionContext.viewController(forKey: .from),
            let from = f.toProtocolVC else {
                fatalError("MMTransitionToProtocol not implement")
        }
        to.view.layoutIfNeeded()
        f.view.layoutIfNeeded()

        container.addSubview(from.view)
        from.view.frame = container.frame
        guard let (pass, passProtocol) = from.container,
              let (original, originalProtocol) = source.pass else {
            transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)
            return
        }

        pass.translatesAutoresizingMaskIntoConstraints = true
        originalProtocol.passWith(status: .willBack)
        passProtocol.containerViewWith(status: .willLeave)
        
        let passFrame: CGRect = pass.convert(pass.frame, to: nil)
        let convertRect: CGRect = original.superview?.convert(source.pass!.view.superview!.frame, to: container) ?? .zero
    
        pass.removeFromSuperview()
        container.addSubview(pass)
        pass.frame = passFrame
        
        UIView.animate(withDuration: self.config.duration, animations: {
            from.view.alpha = 0.0
            pass.frame = convertRect
        }, completion: { (finish) in
            from.view.removeFromSuperview()
            pass.removeFromSuperview()
            pass.constraints.forEach { pass.removeConstraint($0) }
            source.pass?.view.addSubview(pass)
            originalProtocol.passWith(status: .back)
            passProtocol.containerViewWith(status: .leave)
            self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)

        })
    }
}
