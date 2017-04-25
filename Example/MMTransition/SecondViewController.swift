//
//  SecondViewController.swift
//  MMTransition
//
//  Created by Millman YANG on 2017/3/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import MMTransition

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo2"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
