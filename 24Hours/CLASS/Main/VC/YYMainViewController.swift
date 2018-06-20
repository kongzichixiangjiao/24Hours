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
import SwiftDate
import DGElasticPullToRefresh

class YYMainViewController: YYBaseCollectionViewController {
    
    private let locationManager = AMapLocationManager()
    private var weatherModel: YYHeWeather6Model?
    private var airQualityModel: YYAirQualityModel?
    
    var locationString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gd_configLocationManager()
        initViews()
    }
    
    func initViews() {
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = "00AAFF".color0X
        collectionView.yy_register(nibName: YYMainCollectionViewCell.identifier)
    }
    
    func gd_configLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.reGeocodeTimeout = 3
        locationManager.locationTimeout = 3
        
        if (locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            if let weakSelf = self {
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
                        weakSelf.pk_hud_error(text: "定位错误")
                    }
                    else {
                        //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                        weakSelf.pk_hud_error(text: "定位错误")
                    }
                }
                
                if let location = location {
                    NSLog("location:%@", location)
                    HUD.show(.label("\(location.coordinate)"))
                    // 39.904173990885418 116.50982991536458
                    weakSelf.pk_hud(text: "\(location.coordinate)")
                }
                
                if let reGeocode = reGeocode {
                    NSLog("reGeocode:%@", reGeocode)
                    // country:中国;province:北京市; city:北京市; district:朝阳区;
                    if reGeocode.province == reGeocode.city {
                        weakSelf.locationString = reGeocode.district + "," + reGeocode.city.cutShengShi
                    } else {
                        weakSelf.locationString = reGeocode.district + "," + reGeocode.city.cutShengShi + "," + reGeocode.province.cutShengShi
                    }
                    
                    
                    weakSelf.requestWeatherData(location: weakSelf.locationString)
                    weakSelf.requestAirQualtyData(location: weakSelf.locationString)
                    weakSelf.requestAll(location: weakSelf.locationString)
                }
            }
        })) {
            
        } else {
            pk_hud_error(text: "定位错误")
        }
        
//        requestAll(location: "北京市")
    }
    
    func requestAll(location: String) {
        locationString = location
        requestWeatherData(location: location)
        requestAirQualtyData(location: location)
        self.collectionView.contentOffset = CGPoint.zero
    }
    
    func requestWeatherData(location: String) {
        HUD.show(.progress)
        weatherProvider.request(MultiTarget(WeatherAPI.weathers(location: location))) { (result) in
            switch result {
            case .success:
                do {
                    let response = try result.dematerialize()
                    let value = try response.mapJSON()
                    self.weatherModel = YYHeWeather6Model.deserialize(from: value as? [String : Any])
                } catch {
                    HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                }
                break
            case .failure:
                HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                break
            }
            self.collectionView.reloadData()
            HUD.hide(animated: true)
        }
    }
    
    func requestAirQualtyData(location: String) {
        HUD.show(.progress)
        weatherProvider.request(MultiTarget(WeatherAPI.airQuality(location: location))) { (result) in
            switch result {
            case .success:
                do {
                    let response = try result.dematerialize()
                    let value = try response.mapJSON() as! [String : Any]
                    let HeWeather6 = value["HeWeather6"] as? [[String : Any]]
                    self.airQualityModel = YYAirQualityModel.deserialize(from: HeWeather6?.first)
                    (self.slideMenuController()?.leftViewController as! YYLeftViewController).airQualityModel = self.airQualityModel
                } catch {
                    HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                }
                break
            case .failure:
                HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                break
            }
            self.collectionView.reloadData()
            HUD.hide(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYMainViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYMainCollectionViewCell.identifier, for: indexPath) as! YYMainCollectionViewCell
        cell.myDelegate = self
        if let model = weatherModel?.HeWeather6.first {
            cell.row = indexPath.row 
            cell.weatherModel = model
        }
        if let model = airQualityModel {
            cell.airQualityModel = model
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = weatherModel?.HeWeather6.first else {
            return 0
        }
        if model.daily_forecast == nil {
            return 0
        }
        return model.daily_forecast!.count
    }
}

extension YYMainViewController: YYMainCollectionViewCellRefreshDelegate {
    func mainCollectionViewCellRefresh() {
        self.requestWeatherData(location: locationString)
    }
}
