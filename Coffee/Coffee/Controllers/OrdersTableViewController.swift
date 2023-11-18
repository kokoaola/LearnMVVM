//
//  OrdersTableViewController.swift
//  Coffee
//
//  Created by koala panda on 2023/11/16.
//

import Foundation
import UIKit



class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate{
        
    //注文リストのViewModel（ビューに必要なデータ全体）を保持する変数
    var orderListViewModel = OrderListViewModel()
    
    //ビューがロードされたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //注文を取得する
        populateOrders()
    }
    
    
    ///注文データを取得し、テーブルビューを更新する関数
    private func populateOrders() {
        
        //注文データのリソースを作成
        //Webサービスを使ってリソースをロードし、結果に応じて処理を行う
        Webservice().load(resource: Order.all) { [weak self] result in

            //結果が成功か失敗かに応じて処理を分岐
            switch result {
                //成功
            case .success(let orders):
                print(orders)
                //orders配列の各要素をOrderViewModelのインスタンスに変換
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                //テーブルビューをリロードする
                self?.tableView.reloadData()
                //失敗
            case .failure(let error):
                //エラーがあればコンソールに出力
                print(error)
            }
        }
    }
    
    
    ///セグエを使って新しいビューコントローラへ遷移する前の準備を行うメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セグエの宛先がUINavigationControllerであることを確認し、
        //その最初のビューコントローラがAddOrderViewControllerであることを確認
        guard let navC = segue.destination as? UINavigationController,
              let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
            //これらの条件に合わない場合はクラッシュさせる
            fatalError("Error performing segue!")
        }
        
        //AddOrderViewControllerのデリゲートを現在のビューコントローラに設定
        addCoffeeOrderVC.delegate = self
    }
    


    ///Saveボタンのタップ時に呼ばれるAddCoffeeOrderDelegateプロトコルのdelegate関数
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        //注文画面を閉じる
        controller.dismiss(animated: true, completion: nil)
        
        //注文オブジェクトからビューモデルを作成
        let orderVM = OrderViewModel(order: order)
        //注文リストに新しい注文を追加
        self.orderListViewModel.ordersViewModel.append(orderVM)
        //テーブルビューに新しい行を追加
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
    
    ///closeボタンのタップ時に呼ばれるAddCoffeeOrderDelegateプロトコルのdelegate関数
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        //注文画面を閉じる
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    ///テーブルビューのセクション数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    ///テーブルビューの各セクションの行数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //注文リストのViewModel配列内の注文数を返す
        return self.orderListViewModel.ordersViewModel.count
    }

    
    ///テーブルビューのセルを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //指定されたインデックスの注文ViewModelを取得
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)

        //セルを再利用キューから取得、OrderTableViewCellはストーリーボードで設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)

        //セルのテキストを設定
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size

        return cell

    }
}
