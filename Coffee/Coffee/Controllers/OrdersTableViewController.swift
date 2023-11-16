//
//  OrdersTableViewController.swift
//  Coffee
//
//  Created by koala panda on 2023/11/16.
//

import Foundation
import UIKit



class OrdersTableViewController: UITableViewController{
        
    //注文リストのViewModelを保持する変数
//    var orderListViewModel = OrderListViewModel()
    
    //ビューがロードされたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //注文を取得する
        populateOrders()
    }
    
    
    //注文データを取得し、テーブルビューを更新する関数
    private func populateOrders() {
        
        //注文データのURLを設定し、正しいURLでなければクラッシュさせる
        guard let coffeeOrdersURL = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        //注文データのリソースを作成
        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        
        //Webサービスを使ってリソースをロードし、結果に応じて処理を行う
        Webservice().load(resource: resource) { [weak self] result in

            //結果が成功か失敗かに応じて処理を分岐
            switch result {
                //成功
            case .success(let orders):
                print(orders)
                //注文のViewModelを更新し、テーブルビューをリロードする
//                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
//                self?.tableView.reloadData()
                //失敗
            case .failure(let error):
                //エラーがあればコンソールに出力
                print(error)
            }

        }
        
    }
    
    //テーブルビューのセクション数を設定
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    //テーブルビューの各セクションの行数を設定
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //注文リストのViewModel内の注文数を返す
//        return self.orderListViewModel.ordersViewModel.count
//    }
//
//    //テーブルビューのセルを設定
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //指定されたインデックスの注文ViewModelを取得
//        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
//
//        //セルを再利用キューから取得
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
//
//        //セルのテキストを設定
//        cell.textLabel?.text = vm.type
//        cell.detailTextLabel?.text = vm.size
//
//        return cell
//
//    }
    
}
