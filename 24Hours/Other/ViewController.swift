//
//  ViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/12.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Moya

class ViewController: YYBaseViewController {

    var search: AMapSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

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

