//
//  MMTransition+Check.swift
//  MMTransition
//
//  Created by Millman on 2019/3/21.
//

import Foundation
extension UIViewController {
    var fromProtocolVC: (MMTransitionFromProtocol & UIViewController)? {
        get {
            
            return UIViewController.findFromVCWithProtocol(vc: self)
        }
    }
    
    var toProtocolVC: (MMTransitionToProtocol & UIViewController)? {
        get {
            return UIViewController.findToVCWithProtocol(vc: self)
        }
    }
    
    static func findFromVCWithProtocol(vc: UIViewController) -> (MMTransitionFromProtocol & UIViewController)? {
        if let pass = vc as? MMTransitionFromProtocol & UIViewController , pass.willPassView?() ?? true {
            return pass
        } else {
            var find: (MMTransitionFromProtocol & UIViewController)?
            vc.children.forEach { (vc) in
                if let f = UIViewController.findFromVCWithProtocol(vc: vc) {
                    find = f
                }
            }
            return find
        }
    }
    
    static func findToVCWithProtocol(vc: UIViewController) -> (MMTransitionToProtocol & UIViewController)? {
        
        if let pass = vc as? MMTransitionToProtocol & UIViewController {
            return pass
        } else {
            var find: (MMTransitionToProtocol & UIViewController)?
            vc.children.forEach { (vc) in
                if let f = UIViewController.findToVCWithProtocol(vc: vc) {
                    find = f
                }
            }
            return find
        }
    }
    
}
