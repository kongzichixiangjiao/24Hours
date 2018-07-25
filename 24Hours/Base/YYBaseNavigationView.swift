//
//  YYBaseNavigationView.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/21.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYBaseNavigationViewDelegate: class {
    func baseNavigationViewLeftButtonClicked()
    func baseNavigationViewRightButtonClicked()
}

class YYBaseNavigationView: UIView {

    weak var myDelegate: YYBaseNavigationViewDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var myTitle: String! {
        didSet {
            titleLabel.text = myTitle
        }
    }
}
