//
//  WeatherListViewModelTest.swift
//  GoodWeatherTests
//
//  Created by koala panda on 2023/11/27.
//

import XCTest
@testable import GoodWeather



/// WeatherListViewModelの機能をテストするクラス
final class WeatherListViewModelTests: XCTestCase {
    
    //テスト対象のWeatherListViewModel
    private var weatherListVM: WeatherListViewModel!
    
    //各テスト開始前に実行されるセットアップメソッド
    override func setUp() {
        super.setUp()
        
        //WeatherListViewModelのインスタンスを生成し、初期データを追加
        self.weatherListVM = WeatherListViewModel()
        
        //Houstonのサンプル気温データを作成
        self.weatherListVM.addWeatherViewModel(WeatherViewModel(weather: WeatherResponse(name: "Tokyo", main: Weather(temp: 32, humidity: 0))))

        //Austinの気温データを追加
        self.weatherListVM.addWeatherViewModel(WeatherViewModel(weather: WeatherResponse(name: "London", main: Weather(temp: 72, humidity: 0))))
    }
    
    //摂氏への変換が正常に行われることを確認するテストメソッド
    func test_should_be_able_to_convert_to_celsius_successfully() {

        //摂氏に変換された期待する温度値
        let celsiusTemperatures = [0.0,22.0]
        
        //単位を摂氏に更新
        self.weatherListVM.updateUnit(to: .celsius)
//        settingsViewModel.selectedUnit = .celsius

        //変換後の各気温が期待値と一致するか確認
        for (index, vm) in self.weatherListVM.weatherViewModels.enumerated() {
            print("+++++++")
            print(round(vm.temperature), round(celsiusTemperatures[index]))
            print("+++++++")
            
            XCTAssertEqual(round(vm.temperature),round(celsiusTemperatures[index]))
        }
    }
    
    //テスト後のクリーンアップを行うメソッド
    override func tearDown() {
        super.tearDown()
    }
}


