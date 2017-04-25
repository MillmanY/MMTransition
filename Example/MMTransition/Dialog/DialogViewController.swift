//
//  DialogViewController.swift
//  MMTransition
//
//  Created by Millman YANG on 2017/3/28.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import MMTransition
class DialogViewController: UIViewController {


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.mmT.present.dialog { (config) in
            config.animateType = .scale(from: 0, to: 1)
            config.dialogType = .size(s: CGSize(width: 300, height: 200))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
