//
//  YYMainTableHeaderView.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/14.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYMainTableHeaderView: UIView {

    @IBOutlet weak var dressLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    
    var row: Int!
    
    var weatherModel: YYWeatherModel! {
        didSet {
            let set = Set<String>.init(arrayLiteral: weatherModel.basic.admin_area, weatherModel.basic.parent_city, weatherModel.basic.location)
            var dress: String = ""
            for s in set {
                dress.append(s)
            }
            dressLabel.text = dress
            temperatureLabel.text = weatherModel.daily_forecast![row].tmp_max + "°"
            weatherLabel.text = weatherModel.daily_forecast![row].cond_txt_d
        }
    }
    
    var airQualityModel: YYAirQualityModel! {
        didSet {
            if let model = airQualityModel.air_now_city {
                airQualityLabel.text = "空气之量：" + model.qlty
            } else {
                airQualityLabel.text = "空气之量：" + "--"
            }
        }
    }
    
}
