//
//  ViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/12.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    var search: AMapSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "area", ofType: "plist")
        let arr = NSArray.init(contentsOfFile: path!)
        if let list = [YYAreaModel].deserialize(from: arr) {
            print(list)
        }
        
        
        weatherProvider.request(MultiTarget(WeatherAPI.weathers(city: "CHBJ000100"))) { (result) in
            let response = try! result.dematerialize()
            let value = try! response.mapJSON()
            print(value)
            print(YYWeatherModel.deserialize(from: value as! [String : Any])?.status)
            print(YYWeatherModel.deserialize(from: value as! [String : Any])?.weather?.first)
            print(YYWeatherModel.deserialize(from: value as! [String : Any])?.weather?.first?.city_name)
            switch result {
            case .success: break
            case .failure: break
            }

        }
        
    }
    
    func gd_requestWeatherData() {
        search = AMapSearchAPI()
        search.delegate = self
        
        let req:AMapWeatherSearchRequest! = AMapWeatherSearchRequest.init()
        
        req.city = "110000"
        
        //AMapWeatherType.live为实时天气；AMapWeatherType.forecast为预报天气
        req.type = AMapWeatherType.live
        
        self.search.aMapWeatherSearch(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: AMapSearchDelegate {
    func onWeatherSearchDone(_ request: AMapWeatherSearchRequest!, response: AMapWeatherSearchResponse!) {
        let live = response.lives.first!
        print(live.adcode, live.province, live.city, live.weather, live.temperature, live.windDirection, live.windPower, live.humidity, live.reportTime)
        
    }
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print("Error:\(error)")
    }
}














