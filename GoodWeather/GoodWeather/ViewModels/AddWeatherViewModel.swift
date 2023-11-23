//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation


///天気を追加するときのアクションとして特定の都市の天気情報を取得してViewModelに変換するビューモデルクラス
class AddWeatherViewModel {
    
    ///指定された都市の天気情報を取得し、その結果をWeatherViewModelで返すメソッド
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
        
        //都市名に基づいて天気情報のURLを生成
        let weatherURL = Constants.Urls.urlForWeatherByCity(city: city)
        
        //取得したデータをWeatherResponseにデコードするResourceを作成
        let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        
        //Webサービスを使用してリソースをロードし、結果に基づいて処理を行う
        //loadメソッド内でResourceのクロージャを実行
        Webservice().load(resource: weatherResource) { (result) in
            
            //取得した天気情報をWeatherViewModelに変換してcompletionハンドラに渡す
            if let weatherResource = result {
                let vm = WeatherViewModel(weather: weatherResource)
                //addWeatherメソッドが非同期に天気情報を取得し、それをビューモデルに変換した後、そのビューモデルをcompletionハンドラを通して呼び出し元に渡す
                completion(vm)
            }
            
        }
        
    }
    
}

