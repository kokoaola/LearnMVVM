//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/20.
//

import Foundation
import UIKit


protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}


class AddWeatherCityViewController: UIViewController {
    
    
    private var addWeatherVM = AddWeatherViewModel()
    var delegate: AddWeatherDelegate?
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            //気象情報を取得するためのURLを作成
//            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=b39d32abf80c2b7cefb59f0510125b12&units=metric")!
//
//
//            //リクエストのリソースを作成
//            //urlプロパティの初期化のためにweatherURLを渡し、parseプロパティとしてクロージャを渡してる
//            let weatherResource = Resource<Any>(url: weatherURL) { data in
//                return data
//            }
//
//            //URLを渡してWebserviceクラスのloadメソッドを呼び出す
//            Webservice().load(resource: weatherResource) { result in
//
//            }
            
            //addWeatherVMは指定された都市の天気情報を取得し、その結果をWeatherViewModelで返すメソッド
            addWeatherVM.addWeather(for: city) { (vm) in
                //ViewModel を天気リストに送り返す
                self.delegate?.addWeatherDidSave(vm: vm)
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
