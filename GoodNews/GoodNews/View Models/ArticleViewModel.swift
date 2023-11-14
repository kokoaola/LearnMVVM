

import Foundation


///特定の1つのニュース記事を表示する親ビューモデル
//記事のリストを管理するViewModel
struct ArticleListViewModel {
    let articles: [Article]
}


//機能の分離と組織化：extensionを使うことで、ViewModelの基本的な構造（プロパティの定義など）と、それに関連する機能や計算プロパティ（たとえば、記事の数を取得する関数や記事のタイトルと説明を取得するプロパティ）を分けて、コードを整理できます。

//可読性の向上：基本的なデータ構造と追加のビジネスロジックを分離することで、コードの可読性が向上します。これにより、他の開発者がコードを理解しやすくなり、メンテナンスが容易になります。

//再利用性の向上：特定の機能をextensionに分離することで、その機能を他の場所で再利用しやすくなります。例えば、別のViewModelで同様の機能が必要な場合、同じextensionを再利用できる可能性があります。

extension ArticleListViewModel {
    //セクション数を返すプロパティ、ここでは1固定
    var numberOfSections: Int {
        return 1
    }
    
    //指定されたセクションの行数を返す、ここでは記事の数
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    //指定されたインデックスの記事を返す
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

//単一の記事を表すViewModel
struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    //記事を初期化
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    //記事のタイトルを返すプロパティ
    var title: String {
        return self.article.title
    }
    
    //記事の説明を返すプロパティ
    var description: String {
        return self.article.description
    }
}
