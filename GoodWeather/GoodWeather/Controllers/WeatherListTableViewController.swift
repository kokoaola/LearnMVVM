//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/20.
//

import Foundation
import UIKit




class WeatherListTableViewController: UITableViewController {
    
    //ビューがロードされたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビゲーションバーのタイトルを大きく表示する設定
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        return 1
    }
    
    //各行のセルのUIを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルを再利用キューから取得し、WeatherCell型としてキャスト
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        //カスタムセルのラベルに天気情報を設定
        cell.cityNameLabel.text = "Houston"
        cell.temperatureLabel.text = "70°"
        return cell
    }
    
}
