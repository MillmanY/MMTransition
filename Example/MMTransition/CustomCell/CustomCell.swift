//
//  CustomCell.swift
//  MMTransition
//
//  Created by Millman YANG on 2017/5/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
