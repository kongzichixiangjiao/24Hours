//
//  UITableView+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension UITableView {
    func yy_register(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return self.ga_nameOfClass
    }
}
