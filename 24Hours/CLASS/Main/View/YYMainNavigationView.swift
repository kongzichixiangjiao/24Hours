//
//  YYMainNavigationView.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYMainNavigationViewDelegate: class {
    func mainNavigationViewClickRightButton()
}

class YYMainNavigationView: UIView {

    weak var delegate: YYMainNavigationViewDelegate?
    
    @IBAction func add(_ sender: UIButton) {
        delegate?.mainNavigationViewClickRightButton()
    }
}
