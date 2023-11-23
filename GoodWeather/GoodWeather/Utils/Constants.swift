//
//  Constants.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation

///URLの構築に使用するためのクラス、都市名が挿入されたURLを作成できる
struct Constants {
    
    struct Urls {
        static func urlForWeatherByCity(city: String) -> URL {
            
            // get the default settings for temperature
            // let userDefaults = UserDefaults.standard
            // let unit = (userDefaults.value(forKey: "unit") as? String) ?? "imperial"
            
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=b39d32abf80c2b7cefb59f0510125b12&units=imperial")!
        }
        
    }
    
}
