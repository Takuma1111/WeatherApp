//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import Foundation

struct weatherModel : Codable{
    let title:String
    let link:String
    let forecasts:[Forecasts]
}
struct Forecasts : Codable{
    let date : String
    let dateLabel : String
    let telop : String
//    let detail : Detail
    let image : Image
}

struct Detail : Codable{
    let weather : String
    let wind : String
    let wave : String
}

struct Image : Codable{
    let title: String
    let url : String
    let width : Int
    let height : Int
}
