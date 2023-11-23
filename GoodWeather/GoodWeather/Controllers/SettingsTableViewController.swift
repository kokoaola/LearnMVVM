//
//  SettingTableViewController.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation
import UIKit


///アプリの設定画面を表すクラス
class SettingsTableViewController: UITableViewController {
    
    //設定情報を管理するViewModel
    private var settingsViewModel = SettingsViewModel()
    //設定変更完了時に通知するためのデリゲート
//    var delegate: SettingsDelegate?
    
    //ビューが読み込まれたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビゲーションバーのタイトルを大きく表示
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //「完了」ボタンのアクション
//    @IBAction func done() {
//        //デリゲートが設定されていれば、設定完了を通知
//        if let delegate = self.delegate {
//            delegate.settingsDone(vm: settingsViewModel)
//        }
//        //ビューコントローラを閉じる
//        self.dismiss(animated: true, completion: nil)
//    }
    
    ///テーブルビューのセクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///セルが選択されたときの処理
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //表示されている全セルのチェックマークを削除
//        tableView.visibleCells.forEach { cell in
//            cell.accessoryType = .none
//        }
//        //選択されたセルにチェックマークを設定し、選択された単位をViewModelに保存
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .checkmark
//            let unit = Unit.allCases[indexPath.row]
//            settingsViewModel.selectedUnit = unit
//        }
//    }
    
    ///セルの選択が解除されたときの処理
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        //セルのチェックマークを削除
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .none
//        }
//    }
    
    ///セクション内の行数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    ///セルを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //設定項目を取得
        let settingsItem = settingsViewModel.units[indexPath.row]
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        //セルのテキストに設定項目の表示名を設定
        cell.textLabel?.text = settingsItem.displayName
        //選択されている単位にはチェックマークを設定
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}
