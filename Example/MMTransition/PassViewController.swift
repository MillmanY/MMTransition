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
    @IBOutlet weak var imageView: CustomImageView!
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

extension PassViewController: MMTransitionToProtocol {    
    var container: (view: UIView, delegate: ContainerViewProtocol)? {
        return (imageView, imageView)
    }
}
