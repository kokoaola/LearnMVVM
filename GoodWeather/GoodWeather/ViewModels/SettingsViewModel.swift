//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation


import Foundation

/// 気温の単位を表すenum
enum Unit: String, CaseIterable {
    //摂氏
    case celsius = "metric"
    //摂氏
    case fahrenheit = "imperial"
}

/// Unit enumの拡張。表示用の名前を提供する
///AppDelegate内にデフォルト設定をセットアップするプライベートメソッドsetupDefaultSettings()があり、初回起動時に実行される
extension Unit {
    
    //単位に対応する表示名を返すcomputed property
    var displayName: String {
        get {
            switch(self) {
            case .celsius:
                //摂氏の場合は"Celcius"を返す
                return "Celsius"
            case .fahrenheit:
                //華氏の場合は"Fahrenheit"を返す
                return "Fahrenheit"
            }
        }
    }
}



/// 設定に関連するデータを扱うビューモデル
class SettingsViewModel {
    
    //利用可能な全単位を返す
    let units = Unit.allCases
    
    //選択されている単位をUserDefaultsから取得、または保存するcomputed property
    var selectedUnit: Unit {
        //ユーザーデフォルトから値を取得してUnitに変換
        get {
            //UserDefaultsから"unit"キーで保存された単位を取得
            let userDefaults = UserDefaults.standard
            var unitValue = ""
            if let value = userDefaults.value(forKey: "unit") as? String {
                unitValue = value
            }
            //取得した値（文字列）をUnit enumに変換して返す
            return Unit(rawValue: unitValue) ?? Unit.celsius
        }
        //単位の値を変更するたびにユーザーデフォルトに保存
        set {
            //新しい値をUserDefaultsに"unit"キーで保存
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
    
}
