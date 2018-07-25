//
//  AppDelegate+Extension.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

import SlideMenuControllerSwift
extension AppDelegate {
    
    func rooter() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryboard.instantiateInitialViewController()
        let leftStoryboard = UIStoryboard(name: "Left", bundle: nil)
        let leftViewController = leftStoryboard.instantiateInitialViewController() as! YYLeftViewController
        let rightStoryboard = UIStoryboard(name: "Right", bundle: nil)
        let rightViewController = rightStoryboard.instantiateInitialViewController() as! YYRightViewController
        
        rightViewController.mainVC = mainViewController as! YYMainViewController
        leftViewController.mainVC = mainViewController as! YYMainViewController
        
        slideMenuOptions()
        
        let vc = SlideMenuController(mainViewController: mainViewController!, leftMenuViewController: leftViewController)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func slideMenuOptions() {
        
    }
    
}

extension AppDelegate {
    
    func AMapRegister() {
        AMapServices.shared().apiKey = "023a97249df79500209cc99475397902"
    }
    
}

import RealmSwift
extension AppDelegate {
    
    func realmConfig() {
        /* Realm 数据库配置，用于数据库的迭代更新 */
        let schemaVersion: UInt64 = 0
        let config = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
            
            /* 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构 */
            if (oldSchemaVersion < schemaVersion) {}
            
            /* 如果属性改变后，想要保留原来已存在的数据来更新新的属性值，在属性变化后将 schemaVersion 加 1 ，并将 config 改为如下，其余不变。 */
            /*
            if (oldSchemaVersion < schemaVersion) {
                
                migration.enumerateObjects(ofType: Dog.className()) { oldObject, newObject in
                    
                    /* 将 Dog 表中旧的 firstName 和 lastName 属性删除，数据保留合并为 fullName 属性 */
                    let firstName = oldObject!["firstName"] as! String
                    let lastName = oldObject!["lastName"] as! String
                    newObject!["fullName"] = "\(firstName) \(lastName)"
                }
            }
             */
            
            /*如果是只是属性重命名，想保留原来已经存在的数据，重命名以后将 schemaVersion 加 1 ，并将 config 改为如下，其余不变，并且重命名操作应该在调用上面 enumerateObjects(ofType: _:) 之外完成。*/
            /*
             /* 将 Dog 表的 name 属性重命名为 fullName */
             migration.renameProperty(onType: Dog.className(), from: "name", to: "fullName")
             */
        })
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            
            /* Realm 成功打开，迁移已在后台线程中完成 */
            if let _ = realm {
                
                print("Realm 数据库配置成功")
            }
                /* 处理打开 Realm 时所发生的错误 */
            else if let error = error {
                
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
    
}
