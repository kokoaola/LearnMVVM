//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/20.
//

import Foundation
import UIKit




class WeatherListTableViewController: UITableViewController,AddWeatherDelegate {
    private var weatherListViewModel = WeatherListViewModel()
    
    
    //ビューがロードされたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビゲーションバーのタイトルを大きく表示する設定
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        /*
        //Web サービスとコードが機能するかどうかを確認
        //リソースを作成（クロージャはまだ実行されない）
        let resource = Resource<WeatherResponse>(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=tokyo&appid=b39d32abf80c2b7cefb59f0510125b12&units=metric")!) { data in
            return try? JSONDecoder().decode(WeatherResponse.self, from: data)
        }
        
        //作成したリソースを使用して、非同期に天気情報を取得、完了するとクロージャを実行しデータをweatherResponseに格納
        Webservice().load(resource: resource) { weatherResponse in
            if let weatherResponse = weatherResponse{
                print(weatherResponse)
            }
        }
        */
    }
    
    //テーブルビューのセクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //テーブルビューの各行の高さを設定
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //テーブルビューの各セクションにおける行数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    //各行のセルのUIを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルを再利用キューから取得し、WeatherCell型としてキャスト
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        //カスタムセルのラベルにハードコードした天気情報を設定
//        cell.cityNameLabel.text = "Houston"
//        cell.temperatureLabel.text = "70°"
        //指定されたインデックスのビューモデルを返す
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherVM)
        
        return cell
    }
    
    ///segueを使って画面遷移を準備するためのメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //segueの識別子がストーリーボードで設定した識別子と一致している場合、prepareSegueForAddWeatherCityViewControllerを実行
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        }
    }
    
    
    ///AddWeatherCityViewControllerへのsegueを準備するためのメソッド
    func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        //segueの宛先がUINavigationControllerであることを確認し、そうでない場合はクラッシュ
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        //UINavigationControllerの最初のビューコントローラがAddWeatherCityViewControllerであることを確認し、そうでない場合はクラッシュ
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            
            fatalError("AddWeatherCityController not found")
        }
        
        //AddWeatherCityViewControllerのdelegateプロパティに自身を設定
        addWeatherCityVC.delegate = self
    }
    
    
    //デリゲートメソッド
    //AddWeatherCityViewControllerでSaveボタンが押されたら発動するメソッド
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
    }

}
