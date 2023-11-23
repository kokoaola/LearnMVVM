//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Weather
}

struct Weather: Decodable {
    //温度
    let temp: Double
    //湿度
    let humidity: Double
}


//元のJSONはこういう階層になってる
//{
//"coord":{
//    "lon":139.6917,
//    "lat":35.6895
//},
//"weather":[
//    {
//        "id":803,
//        "main":"Clouds",
//        "description":"broken clouds",
//        "icon":"04d"
//    }
//],
//"base":"stations",
//"main":{
//    "temp":20.13,
//    "feels_like":19.87,
//    "temp_min":18.22,
//    "temp_max":21.44,
//    "pressure":1008,
//    "humidity":64
//},
//"visibility":10000,
//"wind":{
//    "speed":5.66,
//    "deg":180
//},
//"clouds":{
//    "all":75
//},
//"dt":1700718160,
//"sys":{
//    "type":2,
//    "id":268395,
//    "country":"JP",
//    "sunrise":1700688262,
//    "sunset":1700724650
//},
//"timezone":32400,
//"id":1850144,
//"name":"Tokyo",
//"cod":200
//}

