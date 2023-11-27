//
//  SettingViewModelTests.swift
//  GoodWeatherTests
//
//  Created by koala panda on 2023/11/27.
//

import XCTest
@testable import GoodWeather


/// SettingsViewModelのテストを行うクラス
final class SettingViewModelTests: XCTestCase {

    //SettingsViewModelのインスタンス
    private var settingsVM: SettingsViewModel!
    
    //テストの前に呼ばれるセットアップメソッド
    override func setUp() {
        super.setUp()
        //SettingsViewModelのインスタンスを生成
        self.settingsVM = SettingsViewModel()
    }

    
    ///新しい設定ビューモデルインスタンスを作成した場合、デフォルトで選択される単位は華氏(Fahrenheit)であることを確認するテスト
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        //settingsVMのselectedUnitが.fahrenheitと等しいことを確認
        XCTAssertEqual(settingsVM.selectedUnit, .fahrenheit)
    }
    
    
    ///新しい設定ビューモデルインスタンスを作成した場合、Fahrenheitが正しく表示されるかテストする
    func test_should_return_correct_display_name_for_fahrenheit() {
        //選択された単位の表示名が"Fahrenheit"と等しいことを確認
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Fahrenheit")
    }
    

    
    ///ユーザーの単位選択がユーザーデフォルトに保存されることをテストする
    func test_should_be_able_to_save_user_unit_selection() {

        //selectedUnitを.celsiusに設定
        self.settingsVM.selectedUnit = .celsius
        //UserDefaultsから"unit"キーの値を取得
        let userDefaults = UserDefaults.standard
        //取得した値がnilでないことを確認
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }

    ///テストの後に呼ばれるクリーンアップメソッド
    override func tearDown() {
        super.tearDown()

        ///テストでユーザーデフォルトに書き込みを行ったので削除する
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
}


    


