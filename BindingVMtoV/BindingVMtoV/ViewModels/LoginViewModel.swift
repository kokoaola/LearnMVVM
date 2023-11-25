//
//  LoginViewModel.swift
//  BindingVMtoV
//
//  Created by koala panda on 2023/11/24.
//

import Foundation

///汎用的なデータバインディングを提供するクラス、データの変更を監視し、変更があった際にリ指定された処理（クロージャ）を実行する
///ジェネリックなのでStringじゃなくてもOK
class Dynamic<T> {
    
    //データの変更を通知するためのクロージャ
    typealias Listener = (T) -> Void
    //データの変更を通知するリスナー
    var listener: Listener?
    
    //監視対象のデータを保持
    var value: T {
        //valueの値が変更されたときにリスナーを呼び出す
        didSet {
            //新しい値を引数として渡す
            listener?(value)
        }
    }
    
    //外部からリスナーを設定するためのメソッド
    func bind(callback: @escaping (T) -> Void) {
        self.listener = callback
    }
    
    //初期値を設定してvalueを初期化
    init(_ value: T) {
        self.value = value
    }
    
}

///ログインに関する情報を管理するビューモデル
struct LoginViewModel {
    var username = Dynamic("")
    var password = Dynamic("")
}
