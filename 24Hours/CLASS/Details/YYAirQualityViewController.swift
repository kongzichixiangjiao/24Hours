//
//  YYAirQualityViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/20.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Moya
import PKHUD

class YYAirQualityViewController: YYBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var airQuality: YYCityAirQualityModel!
    var airQualityList: [YYAirQualityListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "空气质量站点"
        
        initViews()
        initData()
    }
    
    func initData() {
        let path = Bundle.main.path(forResource: "airQualityList", ofType: "plist")
        let arr = NSArray.init(contentsOfFile: path!) as! [[String : Any]]
        if let list = ([YYAirQualityListModel].deserialize(from: arr) as? [YYAirQualityListModel]) {
            self.airQualityList = list
        }
        
        for model in airQualityList {
            switch model.row {
            case 0:
                model.value = airQuality.aqi
                break
            case 1:
                model.value = airQuality.main
                break
            case 2:
                model.value = airQuality.qlty
                break
            case 3:
                model.value = airQuality.pm10
                break
            case 4:
                model.value = airQuality.pm25
                break
            case 5:
                model.value = airQuality.no2
                break
            case 6:
                model.value = airQuality.so2
                break
            case 7:
                model.value = airQuality.co
                break
            case 8:
                model.value = airQuality.o3
                break
            default:
                break
            }
        }
    }
    
    func initViews() {
        tableView.yy_register(identifier: YYLeftTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension YYAirQualityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYLeftTableViewCell.identifier) as! YYLeftTableViewCell
        cell.titleLabel.text = airQualityList[indexPath.row].describe + "->" + airQualityList[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airQualityList.count
    }
}
