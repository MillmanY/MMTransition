//
//  PassViewHelper.swift
//  MMTransition
//
//  Created by Millman on 2019/3/27.
//

import Foundation

class PassViewHelper: NSObject {
    let transitionContext: UIViewControllerContextTransitioning
    var config: Config
    init(transitionContext: UIViewControllerContextTransitioning, config: Config) {
        self.transitionContext = transitionContext
        self.config = config
    }
    
    func goAction() {
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
        let passView = fromProtocol.passView
        let passContainer = toProtocol.containerView
        let passOriginalSuper = passView.superview
        passView.passWith(status: .willLeave)
        fromProtocol.transitionFrom(status: .willLeave)
        passContainer.containerViewWith(status: .willCome)
        toProtocol.transitionTo(status: .willCome)
        let convertFrom: CGRect = passView.superview?.convert(passView.frame, to: nil) ?? .zero
        let convertTo = passContainer.superview?.convert(passContainer.frame, to: container) ?? .zero
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        container.addSubview(passView)
        container.layoutIfNeeded()
        passView.frame = convertFrom
        UIView.animate(withDuration: self.config.duration, animations: {
            passView.frame = convertTo
            toVC.view.alpha = 1.0
        }, completion: {(finish) in
            fromProtocol.transitionFrom(status: .leave)
            passView.passWith(status: .leave)
            toProtocol.transitionTo(status: .come)
            passContainer.containerViewWith(status: .come)
            passContainer.containerViewWith(status: .setContainerWith(view: passView))
            passOriginalSuper?.addSubview(passView)
            passView.resetPassViewLayout()
            self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)
        })
    }
    
    func backAction(isNavigation: Bool = false) {
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
        container.addSubview(from.view)
        from.view.frame = container.frame
        let pass = from.containerView
        pass.translatesAutoresizingMaskIntoConstraints = true
        let original = source.passView
        source.transitionFrom(status: .willBack)
        from.transitionTo(status: .willLeave)
        original.passWith(status: .willBack)
        pass.containerViewWith(status: .willLeave)
        let passFrame: CGRect = pass.convert(pass.frame, to: nil)
        let convertRect: CGRect = original.superview?.convert(original.frame, to: container) ?? .zero
        pass.removeFromSuperview()
        container.addSubview(pass)
        pass.frame = passFrame
        UIView.animate(withDuration: self.config.duration, animations: {
            from.view.alpha = 0.0
            pass.frame = convertRect
        }, completion: { (finish) in
            from.view.removeFromSuperview()
            source.transitionFrom(status: .back)
            from.transitionTo(status: .leave)
            original.passWith(status: .back)
            pass.containerViewWith(status: .leave)
            pass.removeFromSuperview()
            self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled)
        })
    }    
}
