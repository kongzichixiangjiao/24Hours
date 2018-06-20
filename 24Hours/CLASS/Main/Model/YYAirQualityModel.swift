//
//  YYAirQualityModel.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/14.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import HandyJSON

class YYAirQualityModel: HandyJSON {
    var air_now_city: YYCityAirQualityModel?
    var air_now_station: [YYCityAirQualityModel]?
    
    required init() {
        
    }
}


class YYCityAirQualityModel: HandyJSON {
    
    var air_sta: String!
    var pub_time: String!
    var aqi: String!
    var main: String!
    var qlty: String!
    var pm10: String!
    var pm25: String!
    var no2: String!
    var so2: String!
    var co: String!
    var o3: String!
    
    required init() {
        
    }
}

class YYAirQualityListModel: HandyJSON {
    
    var describe: String = ""
    var value: String = ""
    var key: String = ""
    var row: Int = -1
    
    required init() {
        
    }
}
