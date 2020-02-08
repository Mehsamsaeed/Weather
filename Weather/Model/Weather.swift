//
//  Weather.swift
//  Weather
//
//  Created by Mehsam Saeed on 01/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import Foundation
struct  CordinateWeather:Decodable{
    var coord:Coord
    var weather:[Weather]
    var base:String
    var main :Main2
    var wind:wind
    var clouds:clouds
    var dt:Int
    var sys:sys2
    var id: Int
    var name:String
    var cod : Int
}
struct  CityWeather:Decodable{
    var coord:Coord
    var weather:[Weather]
    var base:String
    var main :Main2
    var wind:wind
    var clouds:clouds
    var dt:Int
    var sys:sys
    var id: Int
    var name:String
    var cod : Int
}
struct Coord : Decodable{
    var lon:Double
    var lat:Double
}
struct Weather : Decodable{
    var id:Int
    var main:String
    var description:String
    var icon:String
}
struct Main : Decodable {
    var temp : Double
    var pressure:Double
    var humidity :Int
    var temp_min:Double
    var temp_max :Double
    var sea_level:Double
    var grnd_level:Double
}
struct Main2 : Decodable {
    var temp : Double
    var pressure:Double
    var humidity :Int
    var temp_min:Double
    var temp_max :Double
}

//protocol Main:Decodable{
//    var temp : Double{get set}
//    var pressure:Double{get set}
//    var humidity :Int{get set}
//    var temp_min:Double{get set}
//    var temp_max :Double{get set}
//    var sea_level:Double{get set}
//    var grnd_level:Double{get set}
//}

struct wind:Decodable {
    var speed:Double
    var deg:Double
}
struct clouds:Decodable {
    var all:Int
}
struct sys:Decodable {
    var message:Double
    var country:String
    var sunrise:Int
    var sunset:Int
}
struct sys2:Decodable {
   // var type:Int
   // var id:Int
    var country:String
    var sunrise:Int
    var sunset:Int
}



//struct  Test1:Decodable{
//    var id:Int
//    var name:String
//    var link:String
//    var imageUrl:String
//    var number_of_lessons:Int
//}
//extension AppWeather:Decodable{
//    enum WeatherCodingKeys:String , CodingKeys {
//        case co
//    }
//}
