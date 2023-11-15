//
//  WebService.swift
//  GoodNews
//
//  Created by koala panda on 2023/11/13.
//

import Foundation


class Webservice {
    
    //getArticles関数を定義、URLを受け取り完了時にコールバックする
    // @escaping ([Any]?) -> ()は配列またはnilをパラメータとして受け取り、戻り値がなく、関数の実行が終わった後も呼び出しが可能なクロージャ
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        //URLに基づいてデータタスクを作成し、非同期でデータを取得
        URLSession.shared.dataTask(with: url) { data, response, error in
            //エラーがあればエラー内容を出力し、nilをコールバック
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }

            
            //データがあればデータを出力
            else if let data = data {
                
                //デコードしている型の種類をデコーダに伝える
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
            }
            
            //データタスクを開始
            //.resume()はSwiftのURLSessionDataTaskクラスのメソッド
            //URLSessionでデータタスクを作成する際、タスクはデフォルトで一時停止（"suspended"）状態で始まるため、開始するために.resume()メソッドが必要
            //URLSession.shared.dataTask(with: url) { ... }を使用する場合、.resume()を呼び出すまでデータの取得は開始されない
        }.resume()
        
    }
    
}
