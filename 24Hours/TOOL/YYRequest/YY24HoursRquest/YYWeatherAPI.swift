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

private let kHeweatherKey = "882dec2bdd0247e79a92e61697314d7b"

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum WeatherAPI {
    case weathers(location: String)
    case airQuality(location: String)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://free-api.heweather.com")!
    }
    
    var path: String {
        switch self {
        case .weathers:
            return "/s6/weather/forecast"
        case .airQuality:
            return "/s6/air/now"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weathers:
            return .get
        case .airQuality:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .weathers:
            return "天气情况".data(using: String.Encoding.utf8)!
        case .airQuality:
            return "空气质量".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .weathers(let location):
            return .requestParameters(parameters: ["location" : location, "key" : kHeweatherKey], encoding: URLEncoding.default)
        case .airQuality(let location):
            return .requestParameters(parameters: ["location" : location, "key" : kHeweatherKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
