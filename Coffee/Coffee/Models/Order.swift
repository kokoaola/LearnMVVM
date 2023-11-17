//
//  Order.swift
//  Coffee
//
//  Created by koala panda on 2023/11/16.
//

import Foundation


enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}


enum CoffeeSize: String, Codable, CaseIterable  {
    case small
    case medium
    case large
}


struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}


extension Order {
    
    //ビューモデルからOrderオブジェクトを初期化するイニシャライザ
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        //ビューモデルから必要な値を取得し、無効な場合はnilを返す
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        //初期化を行い、プロパティに値を設定
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}



extension Order {
    
    //全ての注文を取得するためのリソースを提供する静的プロパティ
    static var all: Resource<[Order]> = {
        
        //URLを作成し、無効な場合はクラッシュさせる
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        //URLを使用してOrderの配列のリソースを作成
        return Resource<[Order]>(url: url)
        
    }() //クロージャを即時実行してリソースを初期化
    
    ///新しい注文を作成するためのリソース（情報のカプセル）を提供する静的関数
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        //ビューモデルからOrderオブジェクトを作成
        let order = Order(vm)
        
        //URLを作成し、無効な場合はクラッシュさせる
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        //注文オブジェクトをJSONにエンコードし、失敗した場合はクラッシュさせる
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        //Orderオブジェクトのためのリソースを作成し、HTTPメソッドとボディを設定
        var resource = Resource<Order?>(url: url)
        //リソースの Http メソッドが post である必要があることを伝える
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
        
    }
    
}

