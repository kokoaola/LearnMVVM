//
//  CalculatorUnitTestTests.swift
//  CalculatorUnitTestTests
//
//  Created by koala panda on 2023/11/26.
//

import XCTest

//このプロジェクトである電卓アプリ内のすべてのものはテスト目的で利用可能
@testable import CalculatorUnitTest

/// CalculatorAppのテストケースを定義するクラス
class CalculatorUnitTestTests: XCTestCase {
    
    //Calculatorクラスのインスタンスを生成
    private var calculator: Calculator!

    
    //各テスト開始前に呼ばれるセットアップメソッド
    //インスタンスの生成が何度も行われない
    override func setUp() {
        super.setUp()
        //Calculatorのインスタンスを初期化
        self.calculator = Calculator()
    }
    
    
    
    //2つの数値を減算する機能のテスト
    func test_SubtractTwoNumbers() {
        
        //減算の結果を計算
        let result = self.calculator.subtract(5,2)
        //結果が期待値（3）と等しいことを確認
        XCTAssertEqual(result, 3)
    }
    
    
    //2つの数値を加算する機能のテスト
    func test_AddTwoNumbers() {
        
        //加算の結果を計算
        let result = self.calculator.add(2,3)
        //結果が期待値（5）と等しいことをXCTAssertEqualで確認
        XCTAssertEqual(result, 5)
    }
    
    //各テスト終了後に呼ばれるクリーンアップメソッド
    //データベースやユーザーデフォルトに何かを作成した場合などは、次のテストでのトラブル防止のために書き込んだものをtearDownで必ず削除
    override func tearDown() {
        super.tearDown()
    }
}

