//
//  YYWeatherModel.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON


class YYHeWeather6Model: HandyJSON {
    var HeWeather6: [YYWeatherModel]!
    
    required init() {}
}

class YYWeatherModel: HandyJSON {

    var status: String = ""
    
    var basic: YYWeatherBasicModel!
    var update: YYWeatherUpdateModel!
    var daily_forecast: [YYWeatherForecastModel]?
    
    required init() {}
}

class YYWeatherForecastModel: HandyJSON {
    var cond_code_d: String!
    var cond_code_n: String!
    var cond_txt_d: String!
    var cond_txt_n: String!
    var date: String!
    var hum: String!
    var mr: String!
    var ms: String!
    var pcpn: String!
    var pop: String!
    var pres: String!
    var sr: String!
    var ss: String!
    var tmp_max: String!
    var tmp_min: String!
    var uv_index: String!
    var vis: String!
    var wind_deg: String!
    var wind_dir: String!
    var wind_sc: String!
    var wind_spd: String!
    
    required init() {}
}

class YYWeatherBasicModel: HandyJSON {
    var cid: String!
    var location: String!
    var parent_city: String!
    var admin_area: String!
    var cnty: String!
    var lat: String!
    var lon: String!
    var tz: String!
    required init() {}
}

class YYWeatherUpdateModel: HandyJSON {
    var loc: String!
    var utc: String!
    required init() {}
}


/*
 basic 基础信息
 
 参数    描述    示例值
 location    地区／城市名称    卓资
 cid    地区／城市ID    CN101080402
 lat    地区／城市纬度    40.89576
 lon    地区／城市经度    112.577702
 parent_city    该地区／城市的上级城市    乌兰察布
 admin_area    该地区／城市所属行政区域    内蒙古
 cnty    该地区／城市所属国家名称    中国
 tz    该地区／城市所在时区    +8.0
 */

/*
 update 接口更新时间
 
 参数    描述    示例值
 loc    当地时间，24小时制，格式yyyy-MM-dd HH:mm    2017-10-25 12:34
 utc    UTC时间，24小时制，格式yyyy-MM-dd HH:mm    2017-10-25 04:34
 */
/*
 daily_forecast 天气预报
 
 参数    描述    示例值
 date    预报日期    2013-12-30
 sr    日出时间    07:36
 ss    日落时间    16:58
 mr    月升时间    04:47
 ms    月落时间    14:59
 tmp_max    最高温度    4
 tmp_min    最低温度    -5
 cond_code_d    白天天气状况代码    100
 cond_code_n    晚间天气状况代码    100
 cond_txt_d    白天天气状况描述    晴
 cond_txt_n    晚间天气状况描述    晴
 wind_deg    风向360角度    310
 wind_dir    风向    西北风
 wind_sc    风力    1-2
 wind_spd    风速，公里/小时    14
 hum    相对湿度    37
 pcpn    降水量    0
 pop    降水概率    0
 pres    大气压强    1018
 uv_index    紫外线强度指数    3
 vis    能见度，单位：公里    10

 */

/*
 生活指数等级：
 
 名称    等级
 舒适度指数    舒适、较舒适、较不舒适、很不舒适、极不舒适、不舒适、非常不舒适
 洗车指数    适宜、较适宜、较不宜、不宜
 穿衣指数    炎热、热、舒适、较舒适、较冷、冷、寒冷
 感冒指数    少发、较易发、易发、极易发
 运动指数    适宜、较适宜、较不宜
 旅游指数    适宜、较适宜、一般、较不宜、不适宜
 紫外线指数    最弱、弱、中等、强、很强
 空气污染扩散条件指数    优、良、中、较差、很差
 空调开启指数    长时间开启、部分时间开启、较少开启、开启制暖空调
 过敏指数    极不易发、不易发、较易发、易发、极易发
 太阳镜指数    不需要、需要、必要、很必要、非常必要
 化妆指数    保湿、保湿防晒、去油防晒、防脱水防晒、去油、防脱水、防晒、滋润保湿
 晾晒指数    极适宜、适宜、基本适宜、不太适宜、不宜、不适宜
 交通指数    良好、很好、一般、较差、很差
 钓鱼指数    适宜、较适宜、不宜
 防晒指数    弱、较弱、中等、强、极强
 */

/*
 空气质量计算
 https://www.heweather.com/blog/aqi#qlty
 */
