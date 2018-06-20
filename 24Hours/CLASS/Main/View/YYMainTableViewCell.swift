//
//  YYMainTableViewCell.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/14.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYMainTableViewCell: UITableViewCell {

    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var model: YYWeatherListModel? {
        didSet {
            describeLabel.text = model?.describe
            valueLabel.text = model?.value ?? " "
        }
    }
}



