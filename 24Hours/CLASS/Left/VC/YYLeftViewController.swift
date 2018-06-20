//
//  YYLeftViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYLeftViewController: YYBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var mainVC: YYMainViewController!
    var airQualityModel: YYAirQualityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews() {
        tableView.yy_register(identifier: YYLeftTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension YYLeftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYLeftTableViewCell.identifier) as! YYLeftTableViewCell
        if (indexPath.row == 0) {
            cell.titleLabel.text = "天气预报"
        } else {
            cell.titleLabel.text = "空气质量"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.slideMenuController()?.changeMainViewController(self.mainVC, close: true)
            return
        }
        
        let vc = YYAirQualityAreaViewController(nibName: "YYAirQualityAreaViewController", bundle: nil)
        vc.airQualityModel = airQualityModel
        let nav = UINavigationController(rootViewController: vc)
        self.slideMenuController()?.changeMainViewController(nav, close: true)
    }
}
