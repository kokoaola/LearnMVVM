//
//  Webservice.swift
//  GoodWeather
//
//  Created by koala panda on 2023/11/23.
//

import Foundation


//Web APIや他のデータソースからデータを取得する際に使用する構造体
struct Resource<T> {
    //データソースのURL
    let url: URL
    //取得したデータをアプリケーションが扱いやすい形（モデル）に変換するために使用
    //Data型の引数を取り、Tはジェネリック型返すクロージャ型で、どのようにデータを変換するかを定義する
    //ジェネリック型を使用することで、様々なデータタイプに対応する柔軟性を持たせる
    let parse: (Data) -> T?
}



///非同期でWebサービスからデータを取得し、特定の形式に変換するためのWebserviceクラス
final class Webservice {
    
    //リソースをロードして、結果を非同期で返す関数
    //Resource<T>型の引数と、結果を返すためのクロージャを受け取る。completionクロージャはT?型の値を引数に取り、返り値がない
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        //URLSessionを使って、リソースのURLからデータを非同期に取得
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            print(data)
            
            //データがある場合は、メインスレッドでパースした結果を返す
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                //データがない場合はnilを返す
                completion(nil)
            }
            
            //データタスクを開始する
        }.resume()
    }
}
