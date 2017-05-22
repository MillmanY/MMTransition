//
//  PassViewController.swift
//  MMTransition
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import MMTransition
class PassViewController: UIViewController {
    @IBOutlet weak var containrView: UIView!
    var imageView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.mmT.present.pass { (_) in}
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension PassViewController: PassViewToProtocol {
    var containerView: UIView {
        get {
            return containrView
        }
    }
    func transitionWillStart(passView: UIView) {
        
    }
    
    func transitionCompleted(passView: UIView) {
        
        guard let imageV = passView as? UIImageView else {
            return
        }
        imageView = imageV
        containrView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": passView]))
        containrView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": passView]))

    }
}
