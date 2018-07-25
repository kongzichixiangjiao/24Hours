//
//  YYLocationModel.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/21.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import HandyJSON
import RealmSwift

class YYLocationModel: HandyJSON {
    
    var admin_area: String = "" // 该地区／城市所属行政区域
    var cid: String = "" // 地区／城市ID
    var cnty: String = "" // 该地区／城市所属国家名称
    var lat: String = "" // 地区／城市纬度
    var location: String = "" // 地区／城市名称
    var lon: String = "" // 地区／城市经度
    var parent_city: String = "" // 该地区／城市的上级城市
    var tz: String = "" // 该地区／城市所在时区
    
    required init() {
    
    }
}


class YYAMapLocationModel: Object, HandyJSON {
    
    @objc dynamic var error_code: Int = -9999
    @objc dynamic var locationCoordinate: String = ""
    @objc dynamic var formattedAddress: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var province: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var district: String = "" ///区
    @objc dynamic var citycode: String = "" ///城市编码
    @objc dynamic var adcode: String = "" ///区域编码
    @objc dynamic var street: String = "" ///街道名称
    @objc dynamic var number: String = "" ///门牌号

}
