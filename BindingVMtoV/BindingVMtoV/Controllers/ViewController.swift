//
//  ViewController.swift
//  BindingVMtoV
//
//  Created by koala panda on 2023/11/24.
//

import UIKit

///MVとViewをコードでバインディングする
///UIKit には組み込みのバインディングがないため、コードを記述する
/*
1.ViewControllerの初期化: viewDidLoad()メソッド内で、バインディングするクロージャを設定。これによりDynamic型のusernameとpasswordプロパティがテキストフィールドの値の変更を監視し、変更時にテキストフィールドを更新する

2.テキストフィールドの設定: usernameTextFieldとpasswordTextFieldは、ユーザーの入力を受け取るためのBindingTextFieldインスタンス。これらのフィールドは、ユーザーの入力をloginVMの対応するプロパティにバインドする

3.メソッドのトリガー: Fetch Login Infoボタンをタップ後fetchLoginInfo()メソッドが呼び出される
 
 遅延実行: DispatchQueue.main.asyncAfterを使用して、2秒後に特定のコードブロックを実行
 
 ユーザー名とパスワードの設定: 2秒後、loginVM（LoginViewModelインスタンス）のusernameとpasswordプロパティに、事前に定義された値（この場合は"marydoe"と"password"）が設定
 

 データバインディング: loginVMのusernameとpasswordはDynamic型であるため、これらの値が変更されると、それぞれのbindメソッドによって登録されたクロージャが呼び出される

 UIの更新: usernameとpasswordのバインディングされたクロージャは、テキストフィールドのtextプロパティを更新するため、テキストフィールドの表示が新しい値に変更される
*/


/// ViewControllerクラスはUI要素を初期化し、ログイン機能を提供する
class ViewController: UIViewController {
    
    
    //ログイン処理を担当するViewModel
    private var loginVM = LoginViewModel()
    
    //ビューがロードされた後の初期設定を行う
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///ロードされるたびにバインディングするクロージャを設定
        loginVM.username.bind { [weak self] text in
            self?.usernameTextField.text = text
        }
        
        ///ロードされるたびにバインディングするクロージャを設定
        loginVM.password.bind { [weak self] text in
            self?.passwordTextField.text = text
        }
        
        //UIのセットアップを行う
        setupUI()
    }
    
    lazy var usernameTextField: UITextField = {
        
        let usernameTextField = BindingTextField()
        usernameTextField.placeholder = "Enter username"
        usernameTextField.backgroundColor = UIColor.lightGray
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.bind { [weak self] text in
            self?.loginVM.username.value = text
        }
        
        return usernameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        
        let passwordTextField = BindingTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter password"
        passwordTextField.backgroundColor = UIColor.lightGray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.bind { [weak self] text in
            self?.loginVM.password.value = text
        }
        
        return passwordTextField
        
    }()
    
    
    
    //ログインボタンが押されたときのアクション
    @objc func login() {
        //ユーザー名とパスワードをコンソールに出力
        print(loginVM.username.value)
        print(loginVM.password.value)
    }
    
    ///ログイン情報呼び出しボタンが押されたときのアクション
    @objc func fetchLoginInfo() {
        ///valueが変更されるとDynamic型のdidsetが発動して、viewDidLoadでbindで設定したクロージャが毎回実行される
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.loginVM.username.value = "koala"
            self?.loginVM.password.value = "password"
        }
    }
    
    
    //UIコンポーネントを設定するプライベートメソッド
    private func setupUI() {
    
        
        //ログインボタンの設定
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.gray
        //ボタンの内側をタッチされると、log in というセレクター関数が呼び出される
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        ///ログイン情報を呼び出すボタンの設定
        let loginInfoButton = UIButton()
        loginInfoButton.setTitle("Fetch Login Info", for: .normal)
        loginInfoButton.backgroundColor = UIColor.blue
        //ボタンの内側をタッチされると、log in というセレクター関数が呼び出される
        loginInfoButton.addTarget(self, action: #selector(fetchLoginInfo), for: .touchUpInside)
        
        //スタックビューにテキストフィールドとログインボタンを追加
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, loginInfoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        //スタックビューをビューに追加
        self.view.addSubview(stackView)
        
        //スタックビューの制約を設定
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
}




