//
//  AddCoffeeOrderViewModel.swift
//  Coffee
//
//  Created by koala panda on 2023/11/17.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        //enumの中身を全て取得する
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        //enumの中身を全て取得する
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}
