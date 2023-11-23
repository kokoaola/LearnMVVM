//
//  WeatherViewModel..swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation

/// 天気リストのビューモデルを管理するクラス
class WeatherListViewModel {
    
    //天気ビューモデルの配列をプライベート変数として保持
    private var weatherViewModels = [WeatherViewModel]()
    
    //新しい天気ビューモデルを配列に追加する
    func addWeatherViewModel(_ vm: WeatherViewModel) {
        weatherViewModels.append(vm)
    }
    
    //指定されたセクションの行数を返す
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    //指定されたインデックスのビューモデルを返す
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
}


/// 特定の天気情報を扱うビューモデル
class WeatherViewModel {
    
    //WeatherResponse型の天気情報を保持
    let weather: WeatherResponse
    
    //WeatherResponseを受け取って初期化
    init(weather: WeatherResponse) {
        self.weather = weather
    }
    
    //都市名を返すプロパティ
    var city: String {
        return weather.name
    }
    
    //気温を返すプロパティ
    var temperature: Double {
        return weather.main.temp
    }
}



