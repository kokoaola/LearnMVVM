//
//  Article.swift
//  GoodNews
//
//  Created by koala panda on 2023/11/13.
//

import Foundation



struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}


/*
 
 - 形式
 {
 "status":"ok",
 "totalResults":28,
 "articles":[
 {
 "source":{
 "id":null,
 "name":"Nhk.or.jp"
 },
 "author":null,
 "title":"沖縄本島 各地で約2万2000戸が停電 原因は調査中 - nhk.or.jp",
 "description":"沖縄電力によりますと、12日午後2時35分現在、沖縄本島であわせて2万2110戸が停電しているということです。",
 "url":"https://www3.nhk.or.jp/news/html/20231112/k10014255611000.html",
 "urlToImage":"https://www3.nhk.or.jp/news/html/20231112/K10014255611_2311121435_1112143638_01_02.jpg",
 "publishedAt":"2023-11-12T05:51:11Z",
 "content":"1223522110"
 }
 ]
 }

 
 */
