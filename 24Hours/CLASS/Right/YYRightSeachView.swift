//
//  YYRightSeachView.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/21.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import PKHUD

protocol YYRightSeachViewDelegate: class {
    func rightSeachViewResult(text: String)
}
class YYRightSeachView: UIView, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!

    weak var myDelegate: YYRightSeachViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (!GARegular.match(textField.text!, regularEnum: .zhongwen)) {
            HUD.flash(.label("输入中文"), delay: 0.4)
            return false
        }
        myDelegate?.rightSeachViewResult(text: textField.text!)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}
