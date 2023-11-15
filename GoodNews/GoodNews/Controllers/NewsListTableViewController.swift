//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by koala panda on 2023/11/13.
//

import Foundation
import UIKit

//UITableViewを継承したニュースリストのビューコントローラー
class NewsListTableViewController: UITableViewController{
    
    //記事リストのViewModel
    private var articleListVM: ArticleListViewModel!
    
    //ビューが読み込まれた後に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        //セットアップ関数を呼び出し
        setup()
    }
    
    //ビューの初期設定を行う関数
    private func setup() {
        //ナビゲーションバーのタイトルを大きく表示
        //色はアプリのデリゲート内でオプションを使用して変更している
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //NewsAPIからデータを取得するためのURLを設定
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=jp&apiKey=784809cfd61445c3b9cdc6f4a5bbf68b")!
        
        //Webサービスを使用して記事データを取得
        Webservice().getArticles(url: url) { articles in
            
            //記事が存在する場合、ViewModelを初期化
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                print(articles)
                //テーブルビューをメインスレッドでリロード
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //テーブルビューのセクション数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        //ViewModelのセクション数を返すプロパティを取得
        return self.articleListVM == nil ? 0 :
        //nilの時は0を返す
        self.articleListVM.numberOfSections
    }
    
    //指定されたセクションの行数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //articleListVMから指定されたセクションの行数を返す関数を呼び出している
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    //各セルの内容を設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //記事のセルを取得、セルが存在しない場合はエラー
        //テーブルビューのセルを取得し、適切な型にキャストして、そのセルをさらに設定して使用する
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        //指定された１つの記事のViewModelを取得
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        //セルのタイトルと説明を設定
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        return cell
    }
}
