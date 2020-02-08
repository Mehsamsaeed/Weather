//
//  WeatherLocalService.swift
//  Weather
//
//  Created by Mehsam Saeed on 01/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import Foundation
import Moya
enum WeatherAPI{
    case weatherOfCordinates(Double,Double)
    case weatherOfCity(Int)
}

extension WeatherAPI: TargetType {
    var method: Moya.Method {
          return .get
    }
    
    var sampleData: Data {
          return Data()
    }
    
    var task: Task {
        switch self {
        case .weatherOfCordinates(let lat, let long):
            return .requestParameters(parameters: ["lat" : lat, "lon" : long, "appid":  NetworkManager.AppId], encoding: URLEncoding.default)
            
        case .weatherOfCity(let cityID):
            return .requestParameters(parameters: ["id" : cityID, "appid":  NetworkManager.AppId], encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    var baseURL: URL {
        //  https://api.letsbuildthatapp.com/jsondecodable/course
       // https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
//        case .getData:
//            return ""
        case .weatherOfCity(let cityId):
             return String("")
            
        case .weatherOfCordinates(let lat, let long):
            return String ("")
        }
        
        
        
//        var sampleData: Data {
//            return Data()
//        }
        
//        var task: Task {
//            switch self {
//            case .getData:
//                return .requestParameters(parameters: ["api_key":  NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
//
//            }
//        }
        
//        var headers: [String : String]? {
//            return ["Content-type": "application/json"]
//        }
        
    }
}
