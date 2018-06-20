//
//  YYBaseUrl.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

class YYBaseUrl {
    
    enum ServiceBaseType: String {
        case base = "http://news-at.zhihu.com/api/"
        case jf = "https://jfapp.puxinasset.com/jfapp"
        case all = ""
    }
    
    static let url: String = ServiceBaseType.base.rawValue
    static let urlString: String = ServiceBaseType.all.rawValue
    
}



/*
 YYRequest.share.provider.request(.zgjm(key: "", q: "")) { (result) in
 switch result {
 case .success:
 //                self.dataArr.value += result.value?.mapModel(YYRxSwiftNewsModel.self).stories ?? []
 break
 case .failure:
 print(result.error ?? "--")
 break
 }
 }
 */
