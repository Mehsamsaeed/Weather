//
//  NetworkManager.swift
//  Weather
//
//  Created by Mehsam Saeed on 01/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import Foundation
import Moya
protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

struct NetworkManager: Network {
    static let AppId = "e53f93991071107d9cb204dced390c23"
    let provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getWeatherOfCity(cityID:Int , completion: @escaping (CityWeather)->()){
        provider.request(.weatherOfCity(cityID)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CityWeather.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getWeatherOfCordidate(lat:Double , long:Double , completion: @escaping (CordinateWeather)->()){
        provider.request(.weatherOfCordinates(lat, long)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CordinateWeather.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
