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
import RealmSwift
import CoreTelephony
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
        collectionView.emptyDelegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = "00AAFF".color0X
        collectionView.yy_register(nibName: YYMainCollectionViewCell.identifier)
        
        let nav = YYMainNavigationView.ga_loadView() as!  YYMainNavigationView
        nav.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 64)
        nav.delegate = self
        self.view.addSubview(nav)
        
    }
    
    func gd_configLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.reGeocodeTimeout = 3
        locationManager.locationTimeout = 3
        
        if (locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            if let weakSelf = self {
                
                let model = YYAMapLocationModel()
                
                if let error = error {
                    let error = error as NSError
                    
                    model.error_code = error.code
                    
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
                    
                    model.locationCoordinate = "\(location.coordinate)"
                }
                
                if let reGeocode = reGeocode {
                    NSLog("reGeocode:%@", reGeocode)
                    // country:中国;province:北京市; city:北京市; district:朝阳区;
                    if reGeocode.province == reGeocode.city {
                        weakSelf.locationString = reGeocode.district + "," + reGeocode.city.cutShengShi
                    } else {
                        weakSelf.locationString = reGeocode.district + "," + reGeocode.city.cutShengShi + "," + reGeocode.province.cutShengShi
                    }
                    model.formattedAddress = reGeocode.formattedAddress
                    model.country = reGeocode.country
                    model.province = reGeocode.province
                    model.city = reGeocode.city
                    model.district = reGeocode.district
                    model.citycode = reGeocode.citycode
                    model.adcode = reGeocode.adcode
                    model.street = reGeocode.street
                    model.number = reGeocode.number
                    
                    weakSelf.requestAll(location: weakSelf.locationString)
                }

                let realm = try! Realm()
                try! realm.write {
                    realm.add(model)
                }
                
                print(realm.objects(YYAMapLocationModel.self))
            }
        })) {
            
        } else {
            pk_hud_error(text: "定位错误")
        }
    }
    
    func requestAll(location: String) {
        locationString = location
        requestWeatherData(location: location)
        self.collectionView.contentOffset = CGPoint.zero
        requestDress(location: location)
    }
    
    func requestDress(location: String) {
        HUD.show(.progress)
        weatherProvider.request(MultiTarget(WeatherAPI.dress(location: location))) { (result) in
            switch result {
            case .success:
                do {
                    let response = try result.dematerialize()
                    let value = try response.mapJSON() as! [String:Any]
                    let heWeather6 = value["HeWeather6"] as! [[String:Any]]
                    guard let model = YYLocationModel.deserialize(from: heWeather6.first!["basic"] as? [String : Any]) else {
                        return
                    }
                    
                    self.requestAirQualtyData(location: model.parent_city)
                } catch {
                    HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                }
                break
            case .failure:
                HUD.flash(.label("天气预报被海水冲走了"), delay: 0.8)
                break
            }
            self.collectionView.yy_reloadData()
            HUD.hide(animated: true)
        }
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
                    if (self.weatherModel?.HeWeather6.first?.status != "ok") {
                        HUD.flash(.labeledError(title: "出错了", subtitle: "地址出错了"), delay: 1)
                        self.slideMenuController()?.openRight()
                    }
                } catch {
                    HUD.flash(.label("天气预报被海水冲走了"), delay: 0.4)
                }
                break
            case .failure:
                HUD.flash(.label("天气预报被海水冲走了"), delay: 0.4)
                break
            }
            self.collectionView.yy_reloadData()
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
            self.collectionView.yy_reloadData()
            HUD.hide(animated: true)
        }
    }
    
    @objc func clickedPlaceHolder() {
        self.slideMenuController()?.openRight()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x + 80 < 0) {
            self.slideMenuController()?.openLeft()
        }
    }
}

extension YYMainViewController: YYMainCollectionViewCellRefreshDelegate {
    func mainCollectionViewCellRefresh() {
        self.requestWeatherData(location: locationString)
    }
}

extension YYMainViewController: UICollectionViewPlaceHolderDelegate {
    
    func collectionViewPlaceHolderView() -> UIView {
        let v = UIButton()
        v.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: 100)
        v.center = collectionView.center
        v.setTitle("地址飞走了，请重新选择", for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        v.addTarget(self, action: #selector(clickedPlaceHolder), for: .touchUpInside)
        return v
    }
    
    func collectionViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return false
    }
}

extension YYMainViewController: YYMainNavigationViewDelegate {
    func mainNavigationViewClickRightButton() {
        let rightStoryboard = UIStoryboard(name: "Right", bundle: nil)
        let vc = rightStoryboard.instantiateInitialViewController() as! YYRightViewController
        vc.delegate = self 
        present(vc, animated: true, completion: nil)
    }
    
}

extension YYMainViewController: YYRightViewControllerDelegate {
    func didSelectRow(model: YYSearchDressModel) {
        requestAll(location: model.dress)
    }
}
