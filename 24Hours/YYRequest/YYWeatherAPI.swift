//
//  YYWeatherAPI.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/13.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import Moya

let weatherProvider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum WeatherAPI {
    case weathers(city: String)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://tj.nineton.cn")!
    }
    
    var path: String {
        switch self {
        case .weathers:
            return "/Heart/index/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weathers:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .weathers:
            return "天气情况".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .weathers(let city):
            return .requestParameters(parameters: ["city": city], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
