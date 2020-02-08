//
//  CIty.swift
//  Weather
//
//  Created by Mehsam Saeed on 03/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import Foundation

struct City:Decodable {
    
    var id:Int
    var name:String
    var country:String
    var coord:Coord
    
}
