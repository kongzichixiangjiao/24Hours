//
//  YYRightViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYRightViewController: YYBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainVC: YYMainViewController!
    
    var areas: [String] = ["北京市", "朝阳,北京", "昌平,北京", "漳州,福建", "宁德市"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地点"
        
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

extension YYRightViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYLeftTableViewCell.identifier) as! YYLeftTableViewCell
        cell.titleLabel.text = areas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainVC.requestAll(location: areas[indexPath.row]) 
        self.slideMenuController()?.changeMainViewController(self.mainVC, close: true)
    }
}
