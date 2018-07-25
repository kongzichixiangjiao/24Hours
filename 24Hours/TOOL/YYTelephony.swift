//
//  YYTelephony.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/7/11.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import CoreTelephony

class YYTelephony {

    func telephony() {
        let info = CTTelephonyNetworkInfo()
        
        print(info.currentRadioAccessTechnology)
        
        let carrier = info.subscriberCellularProvider
        print(carrier?.description)
        
        info.subscriberCellularProviderDidUpdateNotifier = {
            [weak self] carrier in
            print(carrier.description)
        }
        
        let center = CTCallCenter()
        center.callEventHandler = {
            [weak self] call in
            let curCalls = center.currentCalls
            print(curCalls)
            print(call.description)
            
            if (call.callState == "CTCallStateDialing") {
                print("正在呼叫状态")
            } else if (call.callState == "CTCallStateDialing") {
                print("断开连接状态")
            } else {
                
            }
        }
    }
}
