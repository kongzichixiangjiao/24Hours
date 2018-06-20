//
//  YYAirQualityAreaViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/20.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit


class YYAirQualityAreaViewController: YYBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var airQualityModel: YYAirQualityModel?
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
    }
    
    func initViews() {
        tableView.yy_register(identifier: YYLeftTableViewCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension YYAirQualityAreaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYLeftTableViewCell.identifier) as! YYLeftTableViewCell
        if let model = airQualityModel {
            cell.titleLabel.text = model.air_now_station![indexPath.row].air_sta
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = airQualityModel {
            if let obj = model.air_now_station {
                return obj.count
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YYAirQualityViewController(nibName: "YYAirQualityViewController", bundle: nil)
        if let model = airQualityModel {
            vc.airQuality = model.air_now_station![indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
