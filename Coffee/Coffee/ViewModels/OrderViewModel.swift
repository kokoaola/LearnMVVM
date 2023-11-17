//
//  OrderViewModel.swift
//  Coffee
//
//  Created by koala panda on 2023/11/16.
//

import Foundation

///ビュー全体にデータを提供するビューモデル、テーブルビューコントローラーに表示しているすべてのデータ
class OrderListViewModel {

    var ordersViewModel: [OrderViewModel]

    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

//一つの注文のインスタンスを作成する関数
extension OrderListViewModel {

    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }

}



///各オーダーに関するモデル
struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
}


