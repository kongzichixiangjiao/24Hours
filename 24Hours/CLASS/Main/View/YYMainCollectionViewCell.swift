//
//  YYMainCollectionViewCell.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/14.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import SnapKit
import DGElasticPullToRefresh

enum YYWeatherDataType: Int {
    case date = 0, // 预报日期
        sr = 1, // 日出时间
        ss = 2, // 日落时间
        mr = 3, // 月升时间
        ms = 4, // 月落时间
        tmp_max = 5, // 最高温度
        tmp_min = 6, // 最低温度
        cond_code_d = 7, // 白天天气状况代码
        cond_code_n = 8, // 晚间天气状况代码
        cond_txt_d = 9, // 白天天气状况描述
        cond_txt_n = 10, // 晚间天气状况描述
        wind_deg = 11, // 风向360角度
        wind_dir = 12, // 风向
        wind_sc = 13, // 风力
        wind_spd = 14, // 风速，公里/小时
        hum = 15, // 相对湿度
        pcpn = 16, // 降水量
        pop = 17, // 降水概率
        pres = 18, // 大气压强
        uv_index = 19, // 紫外线强度指数
        vis = 20 // 能见度，单位：公里
}

protocol YYMainCollectionViewCellRefreshDelegate: class {
    func mainCollectionViewCellRefresh()
}

class YYMainCollectionViewCell: UICollectionViewCell {

    static let identifier = "YYMainCollectionViewCell"
    
    weak var myDelegate: YYMainCollectionViewCellRefreshDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherList: [YYWeatherListModel] = []
    
    var row: Int! {
        didSet {
            headerView.row = row
           
        }
    }
    
    var weatherModel: YYWeatherModel? {
        didSet {
            
            let obj = weatherModel?.daily_forecast![row]
            for model in weatherList {
                switch model.row {
                case YYWeatherDataType.date.rawValue:
                    model.value = "今天：" + (obj?.date ?? "")
                    break
                case YYWeatherDataType.sr.rawValue:
                    model.value = obj?.sr ?? ""
                    break
                case YYWeatherDataType.ss.rawValue:
                    model.value = obj?.ss ?? ""
                    break
                case YYWeatherDataType.mr.rawValue:
                    model.value = obj?.mr ?? ""
                    break
                case YYWeatherDataType.ms.rawValue:
                    model.value = obj?.ms ?? ""
                    break
                case YYWeatherDataType.tmp_max.rawValue:
                    model.value = (obj?.tmp_max ?? "") + "℃"
                    break
                case YYWeatherDataType.tmp_min.rawValue:
                    model.value = (obj?.tmp_min ?? "") + "℃"
                    break
                case YYWeatherDataType.cond_code_d.rawValue:
                    model.value = obj?.cond_code_d ?? ""
                    break
                case YYWeatherDataType.cond_code_n.rawValue:
                    model.value = obj?.cond_code_n ?? ""
                    break
                case YYWeatherDataType.cond_txt_d.rawValue:
                    model.value = obj?.cond_txt_d ?? ""
                    break
                case YYWeatherDataType.cond_txt_n.rawValue:
                    model.value = obj?.cond_txt_n ?? ""
                    break
                case YYWeatherDataType.wind_deg.rawValue:
                    model.value = obj?.wind_deg ?? ""
                    break
                case YYWeatherDataType.wind_dir.rawValue:
                    model.value = obj?.wind_dir ?? ""
                    break
                case YYWeatherDataType.wind_sc.rawValue:
                    model.value = obj?.wind_sc ?? ""
                    break
                case YYWeatherDataType.wind_spd.rawValue:
                    model.value = obj?.wind_spd ?? ""
                    break
                case YYWeatherDataType.hum.rawValue:
                    model.value = obj?.hum ?? ""
                    break
                case YYWeatherDataType.pcpn.rawValue:
                    model.value = obj?.pcpn ?? ""
                    break
                case YYWeatherDataType.pop.rawValue:
                    model.value = obj?.pop ?? ""
                    break
                case YYWeatherDataType.pres.rawValue:
                    model.value = obj?.pres ?? ""
                    break
                case YYWeatherDataType.uv_index.rawValue:
                    model.value = obj?.uv_index ?? ""
                    break
                case YYWeatherDataType.vis.rawValue:
                    model.value = obj?.vis ?? ""
                    break
                default:
                    break
                }
            }
            tableView.reloadData()
            headerView.weatherModel = weatherModel
            DispatchQueue.main.async {
                self.tableView.dg_stopLoading()
            }
        }
    }
    
    var airQualityModel: YYAirQualityModel! {
        didSet {
            headerView.airQualityModel = airQualityModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViews()
        initRefreshView()
        
        let path = Bundle.main.path(forResource: "weatherList", ofType: "plist")
        let arr = NSArray.init(contentsOfFile: path!) as! [[String : Any]]
        if let list = ([YYWeatherListModel].deserialize(from: arr) as? [YYWeatherListModel]) {
            self.weatherList = list
        }
    }
    
    private func initViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.yy_register(identifier: YYMainTableViewCell.identifier)
        tableView.estimatedRowHeight = 50
        tableView.tableHeaderView = headerView
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.width.equalTo(tableView)
            make.height.equalTo(200)
        }
    }
    
    private func initRefreshView() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            if let weakSelf = self {
                weakSelf.myDelegate?.mainCollectionViewCellRefresh()
            }
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    lazy var headerView: YYMainTableHeaderView = {
        let v = YYMainTableHeaderView.ga_loadView() as! YYMainTableHeaderView
        return v
    }()
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
    
}

extension YYMainCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYMainTableViewCell.identifier) as! YYMainTableViewCell
        cell.model = weatherList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
}
