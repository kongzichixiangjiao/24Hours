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
        let leftViewController = leftStoryboard.instantiateInitialViewController()
        let rightStoryboard = UIStoryboard(name: "Right", bundle: nil)
        let rightViewController = rightStoryboard.instantiateInitialViewController()
        
        slideMenuOptions()
        
        let vc = SlideMenuController(mainViewController: mainViewController!, leftMenuViewController: leftViewController!, rightMenuViewController: rightViewController!)
        
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
