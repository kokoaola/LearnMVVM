//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by koala panda on 2023/11/13.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        //タイトルを大きく表示する
        //色はアプリのデリゲート内でオプションを使用して変更している
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //NewsAPIからデータを取得
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=jp&apiKey=784809cfd61445c3b9cdc6f4a5bbf68b")!
        
        Webservice().getArticles(url: url) { _ in
            
        }
    }
}
