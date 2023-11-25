//
//  BindingTextField.swift
//  BindingVMtoV
//
//  Created by koala panda on 2023/11/24.
//

import Foundation
import UIKit



///テキストフィールドの値が変更されるたびにアクションを実行するカスタムUITextFieldクラス
class BindingTextField: UITextField {
    
    //テキストが変更されたときに呼び出されるクロージャ
    var textChanged: (String) -> Void = { _ in }
    
    //インスタンスがプログラム上で作成される際に呼び出される初期化メソッド
    override init(frame: CGRect) {
        //親クラス（UITextField）の同じイニシャライザを呼び出す
        super.init(frame: frame)
        //共通の初期化処理を呼び出し
        commonInit()
    }
    
    //コードからではなく、StoryboardやXIBから生成されたときに呼び出されるイニシャライザ
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //共通の初期化処理を呼び出し
        commonInit()
    }
    
    ///共通の初期化処理、addTargetを使ってテキストフィールドの値が変更されたことを検出するイベントリスナーを設定
    private func commonInit() {
        //編集変更イベントを監視し、textFieldDidChangedメソッドを呼び出す
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    ///テキストが変更されたときに呼び出されるメソッドをバインド
    func bind(callback: @escaping (String) -> Void) {
        //引数で渡されたクロージャがtextChangedプロパティに保存され、テキストフィールドの値が変更されるたびにこのクロージャが実行される
        textChanged = callback
    }
    
    ///テキストフィールドの値が変更されたときに呼び出される
    ///クロージャはtextChangedの型と一致させ、ViewModelて設定
    @objc func textFieldDidChanged(_ textField: UITextField) {
        //テキストフィールドの値が変更されるとtextFieldDidChangedメソッドが呼び出され、textChangedプロパティに保存されたクロージャが、新しい値を引数として実行される
        if let text = textField.text {
            textChanged(text)
        }
    }
    
}
