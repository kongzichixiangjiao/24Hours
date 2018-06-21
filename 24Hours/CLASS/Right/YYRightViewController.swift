//
//  YYRightViewController.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import RealmSwift

class YYRightViewController: YYBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainVC: YYMainViewController!
    
    var areas: [YYSearchDressModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地点"
        
        initViews()
        
        initData()
    }
    
    func initData() {
        let realm = try! Realm()
        let result = realm.objects(YYSearchDressModel.self)
        for dress in result {
            areas.insert(dress, at: 0)
        }
        self.tableView.reloadData()
    }
    
    lazy var searchView: YYRightSeachView = {
        let v = YYRightSeachView.ga_loadView() as! YYRightSeachView
        v.myDelegate = self
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 44)
        return v
    }()
    
    func initViews() {
        tableView.yy_register(identifier: YYLeftTableViewCell.identifier)
        tableView.tableHeaderView = searchView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.view.endEditing(true)
    }
}

extension YYRightViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYLeftTableViewCell.identifier) as! YYLeftTableViewCell
        cell.titleLabel.text = areas[indexPath.row].dress
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainVC.requestAll(location: areas[indexPath.row].dress)
        self.slideMenuController()?.changeMainViewController(self.mainVC, close: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let model = areas[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(model)
        }
        areas.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
}

extension YYRightViewController: YYRightSeachViewDelegate {
    func rightSeachViewResult(text: String) {
        let dress = YYSearchDressModel()
        dress.dress = text
        let realm = try! Realm()
        try! realm.write {
            realm.add(dress)
        }
        areas.append(dress)
        self.tableView.reloadData()
    }
}
