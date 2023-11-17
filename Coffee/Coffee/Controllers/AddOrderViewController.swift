//
//  AddOrderViewController.swift
//  Coffee
//
//  Created by koala panda on 2023/11/16.
//

import Foundation
import UIKit

///プラスを押した時に出現するビューのコントローラー
class AddOrderViewController: UIViewController, UITableViewDelegate,
                              UITableViewDataSource{

    //Addorderビューコントローラービューに表示されるすべてのオーダーを制御
    private var vm = AddCoffeeOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //コーヒーサイズ選択用のセグメントコントロール(ストリーボードではなくコードで追加)
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    //ビューがロードされたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //テーブルビューのイベント（行の選択やタップなど）に対する応答は、このビューコントローラが処理
        self.tableView.delegate = self
        //テーブルビューのデータ（行の数、各行の内容など）の提供は、このビューコントローラが行う
        self.tableView.dataSource = self
        
        //UIのセットアップを行う
        setupUI()
    }
    
    
    
    
    //UI要素のセットアップ(セグメントコントロールを作成)を行う関数
    private func setupUI() {
        
        //コーヒーサイズのセグメントコントロールを作成し、ビューに追加
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.vm.sizes)
        //Auto Layoutを使用する場合は、このプロパティをfalseに設定する
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //サブビューとして現在のビューに追加
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        
        //セグメントコントロールのレイアウトを設定
        //上端をテーブルビューの下端から20ポイントのオフセットで配置
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 0).isActive = true
        //ビューのX軸中央に配置
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    ///テーブルビューの行が選択されたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルにチェックマークをつける
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    ///テーブルビューの行の選択が解除されたときに呼ばれる
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //セルのチェックマークをはずす
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    //テーブルビューの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    
    //テーブルビューのセルのラベル設定する(コーヒーのメニューを全て表示する)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを再利用キューから取得、CoffeeTypeTableViewCellはストーリーボードで設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    
    
    //閉じるボタンのアクション、デリゲートを通じて閉じる処理を伝える
//    @IBAction func close() {
//        if let delegate = delegate {
//            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
//        }
//    }
    
    //保存ボタンのアクション
    @IBAction func save() {
        //テキストフィールドから入力内容を取得
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        //セグメントで選択されたコーヒーのサイズを取得
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        //選択された行のインデックスを取得（選択されたメニュー用）
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee!")
        }
        //各情報をビューモデルに設定
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]

        //ViewModelをJSONに変換し、Webサービスを使用して注文を送信
        Webservice().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
                //成功
            case .success(let order):
                print(order)
//                if let order = order, let delegate = self.delegate {
//                    DispatchQueue.main.async {
//                        delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
//                    }
//                }
                //失敗
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

}
