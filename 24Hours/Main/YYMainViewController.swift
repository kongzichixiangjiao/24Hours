//
//  YYMainViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Moya
import PKHUD

class YYMainViewController: UIViewController {

    let locationManager = AMapLocationManager()
    var areaList: [YYAreaModel]!
    var searchList: [YYAreaModel]!
    
    @IBOutlet weak var l: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAreaData()
        gd_configLocationManager()
        
        print(Date().timeIntervalSince1970)
    }
    
    func gd_configLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        
        locationManager.requestLocation(withReGeocode: false, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            if let location = location {
                NSLog("location:%@", location)
                HUD.show(.label("\(location.coordinate)"))
                // 39.904173990885418 116.50982991536458
            }
            
            if let reGeocode = reGeocode {
                NSLog("reGeocode:%@", reGeocode)
                self?.showWeatherData(city: reGeocode.city)
            }
        })
        self.showWeatherData(city: "北京")
    }
    
    func initAreaData() {
        let path = Bundle.main.path(forResource: "area", ofType: "plist")
        let array = NSArray.init(contentsOfFile: path!)
        if let list = [YYAreaModel].deserialize(from: array) as? [YYAreaModel] {
            areaList = list
        }
    }
    
    func showWeatherData(city: String) {
        print(city)
        searchList = areaList.filter({ (area) -> Bool in
            return area.name == city || area.parent1 == city || area.parent2 == city || area.parent3 == city
        })
        requestWeatherData(cityCode: (searchList.first?.id)!)
    }
    
    func requestWeatherData(cityCode: String) {
        weatherProvider.request(MultiTarget(WeatherAPI.weathers(city: cityCode))) { (result) in
            let response = try! result.dematerialize()
            let value = try! response.mapJSON()
            
            let model = YYWeatherModel.deserialize(from: value as? [String : Any])
            let weather = model?.weather?.first!
            let now = weather?.now!
            let air_quality = now?.air_quality!
            /*
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
             */
            
            
            print(air_quality!.city ?? "-")
            self.l.text = weather!.city_name + weather!.last_update + "\npm25 = " + "\(air_quality!.city?.pm25 ?? 0)" + now!.text
            switch result {
            case .success: break
            case .failure: break
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
