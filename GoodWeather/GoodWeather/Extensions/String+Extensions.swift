//
//  String+Extensions.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation


/// String型の拡張機能を提供する
extension String {
    
    ///都市名にスペースなどが入っていた場合にも、文字列をURLで安全に使用できる形式にエスケープするメソッド
    func escaped() -> String {
        //URLホストで許可されている文字にエンコードし、失敗した場合は元の文字列を返す
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
