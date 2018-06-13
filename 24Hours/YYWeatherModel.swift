//
//  YYWeatherModel.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

class YYWeatherModel: HandyJSON {
    var status: String = ""
    var weather: [YYWeatherDataModel]?
    
    required init() {}
}

class YYWeatherDataModel: HandyJSON {
    var city_id: String!
    var city_name: String!
    var future: YYWeatherFutureModel?
    var last_update: String!
    var now: YYWeatherNowModel?
    required init() {
        
    }
}

class YYWeatherFutureModel: HandyJSON {
    var code1: Int!
    var code2: Int!
    var cop: String!
    var date: String!
    var day: String!
    var high: Int!
    var low: Int!
    var text: String!
    var wind: String!
    
    required init() {
        
    }
}

class YYWeatherNowModel: HandyJSON {
    var air_quality: YYWeatherNowAirQualityModel!
    var alarms: [Any]!
    var code: Int! // 参考WeatherCodeType
    var feels_like: Int!
    var humidity: Int!
    var pressure: Int!
    var pressure_rising: String!
    var temperature: Int!
    var text: String!
    var visibility: String!
    var wind_direction: String!
    var wind_scale: String!
    var wind_speed: String!
    var today: YYWeatherToayModel?
    required init() {
        
    }
}

class YYWeatherNowAirQualityModel: HandyJSON {
    var city: YYWeatherNowAirQualityCityModel?
    var stations: String = ""
    required init() {
        
    }
}
class YYWeatherNowAirQualityCityModel: HandyJSON {
    var aqi: Int!
    var co: String!
    var last_update: String!
    var no2: Int!
    var o3: Int!
    var pm10: Int!
    var pm25: Int!
    var so2: Int!
    var quality: String!
    required init() {
        
    }
    
}

class YYWeatherToayModel: HandyJSON {
    var suggestion: YYWeatherToaySuggestionModel?
    var sunrise: String!
    var sunset: String!
    
    required init() {
        
    }
}

class YYWeatherToaySuggestionModel: HandyJSON {
    var car_washing: YYWeatherToaySuggestionDetailsModel?
    var dressing: YYWeatherToaySuggestionDetailsModel?
    var flu: YYWeatherToaySuggestionDetailsModel?
    var sport: YYWeatherToaySuggestionDetailsModel?
    var travel: YYWeatherToaySuggestionDetailsModel?
    var uv: YYWeatherToaySuggestionDetailsModel?
    required init() {
        
    }
}
class YYWeatherToaySuggestionDetailsModel: HandyJSON {
    var brief: String!
    var details: String!
    required init() {
        
    }
}

enum WeatherCodeType: Int {
 /// 晴
 case sunny = 0
 /// 晴
 case clear = 1
 /// 晴
 case fair1 = 2
 /// 晴
 case fair2 = 3
 
 /// 多云
 case cloudy = 4
 /// 晴间多云
 case partlyCloudy1 = 5
 /// 晴间多云
 case partlyCloudy2 = 6
 /// 大部多云
 case mostlyCloudy1 = 7
 /// 大部多云
 case mostlyCloudy2 = 8
 
 /// 阴
 case overcast = 9
 /// 阵雨
 case shower = 10
 /// 雷阵雨
 case thundershower = 11
 /// 雷阵雨伴有冰雹
 case thundershowerWithHail = 12
 /// 小雨
 case lightRain = 13
 /// 中雨
 case moderateRain = 14
 /// 大雨
 case heavyRain = 15
 /// 暴雨
 case storm = 16
 /// 大暴雨
 case heavyStorm = 17
 /// 特大暴雨
 case severeStorm = 18
 
 /// 冻雨
 case iceRain = 19
 /// 雨夹雪
 case sleet = 20
 /// 阵雪
 case snowFlurry = 21
 /// 小雪
 case lightSnow = 22
 /// 中雪
 case moderateSnow = 23
 /// 大雪
 case heavySnow = 24
 /// 暴雪
 case snowstorm = 25
 
 /// 浮尘
 case dust = 26
 /// 扬沙
 case sand = 27
 /// 沙尘暴
 case duststorm = 28
 /// 强沙尘暴
 case sandstorm = 29
 /// 雾
 case foggy = 30
 /// 霾
 case haze = 31
 /// 风
 case windy = 32
 /// 大风
 case blustery = 33
 /// 飓风
 case hurricane = 34
 /// 热带风暴
 case tropicalStorm = 35
 /// 龙卷风
 case tornado = 36
 
 /// 冷
 case cold = 37
 /// 热
 case hot = 38
 
 /// 未知
 case unknown = 99
}
