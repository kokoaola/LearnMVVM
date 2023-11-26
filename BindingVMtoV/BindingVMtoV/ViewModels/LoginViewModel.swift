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
    
    //初期値を設定してvalueを初期化
    init(_ value: T) {
        self.value = value
    }
    
    //データの変更を通知するためのクロージャ
    typealias Listener = (T) -> Void
    
    ///監視対象のデータを保持するプロパティ
    var value: T {
        //valueの値が変更されると、valueを引数にして自動的にlistenerが呼び出される
        didSet {
            //新しい値を引数として渡してlistenerを実行
            listener?(value)
        }
    }
    
    ///外部からリスナー（クロージャ）を設定するためのメソッド
    func bind(callback: @escaping (T) -> Void) {
        self.listener = callback
    }
    
    ///valueが変更された際に呼び出されるクロージャを保持するプロパティ
    var listener: Listener?
}

///ログインに関する情報を管理するビューモデル
struct LoginViewModel {
    var username = Dynamic("")
    var password = Dynamic("")
}
