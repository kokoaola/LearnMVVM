# デザインパターンとは
コードを書いてプログラムを作る時のパターンのこと
クラスとクラスの関係で構成される
実装すると開発スピードを上げられる（再利用がしやすいから）
どの言語にも使用できるパターン


## MVC（Model-View-Controller）とは
- 代表的なデザインパターンの一つ
- Model-View-Controllerを略してMVCと呼ばれる
- Model、View、Controllerで構成される
- モバイルアプリだけでなく、Webアプリケーションなどにも幅広く適用される
### 構成要素
- Model
    - データとロジックのこと。データは内容が何であっても、モデルとみなす
    - TodoListのタスクなど
- View
    - UIのこと。ユーザーがスクリーンで見るものすべて。ユーザーが操作できるものも含む
    - iPhoneの画面、Webページ、Apple Watch
- Controller
    - 仲介者のこと。モデルとビューの間の通信を行う
    - モデルを取得してビューに表示する
### MVCの問題点
- 機能的には問題がないが、コントローラーに大量のコードを書く必要があるのが欠点。テストが容易でない


## MVVMパターンとは
- MVCの代わりに使用されるデザインパターン
- Model-View-ViewModelを略してMVVMと呼ばれる
- MVCパターンに似ているが、ビュー間をさらに分離できる

### 構成要素
- Model
    -  MVCと同様に、データとビジネスロジックを管理
- View
    - UIのこと。ユーザーがスクリーンで見るものすべて。ユーザーが操作できるものも含む
    - iPhoneの画面、Webページ、Apple Watch
- ViewModel
    - データバインディングを使用してビューとモデルの間を連携、仲介する
    - ビューに表示するデータを変更したり、ユーザーのアクションに応じて更新する

## ModelとViewが直接やりとりすることの問題
- モデルのロジックが膨大になったり、アクセスしてほしくない部分のデータをビューが取得してしまう危険がある
- 例えばパスワードとユーザーネームを決めるプログラムで
### ModelとViewの場合
- 【View】Usernameテキストフィールド、NewPasswordテキストフィールド、ConfirmPasswordテキストフィールド
- 【Model】Usernameプロパティ、NewPasswordプロパティ、ConfirmPasswordプロパティ
- 確認用のConfirmPasswordプロパティは余計

### ModelとViewとViewModelの場合
- 【View】Usernameテキストフィールド、NewPasswordテキストフィールド、ConfirmPasswordテキストフィールド
- 【ViewModel】Usernameプロパティ、NewPasswordプロパティ、ConfirmPasswordプロパティ
- 【Model】Usernameプロパティ、NewPasswordプロパティ
- メリット：ViewModelでパスワードを検証するロジックを追加したりできる

## MVVMとMVCの主な違い
- ビューとモデルの間の仲介: MVCではコントローラー、MVVMではViewModel
- ビューの更新: MVCではビューの変更をDelegateやKVO、NotificationCenterなどで検知させ、更新は全て明示的に行われる。MVVMではデータバインディングで同期を自動でさせ、自動で更新する
- ビューとの結合度: MVCでは、コントローラーが特定のビューに対してより密接に結びついているため、ビューとの再利用性はMVVMよりも限られる。MVVMではビューモデルはビューから独立しているため、異なるビューに対して同じビューモデルを使用することが可能
- テストと保守: MVVMパターンは、ビューとロジックの分離がより明確であるため、テストしやすく、保守が容易


## MVVMを採用した時のプロジェクトのファイル階層について
SwiftUIでMVVM（Model-View-ViewModel）パターンを使用する際のプロジェクトのファイル構成

Model
データとビジネスロジックを含む。
例: データモデル、ユーティリティクラス、ネットワークリクエスト、データベースアクセスなど。

View
ユーザーインターフェースを定義。
SwiftUIのビューコンポーネントやビューモディファイアなどが含まれる。
例: ContentView.swift, DetailView.swift などのビューファイル。

ViewModel
ビューに表示するためのデータを管理し、モデルとの間の仲介者として機能。
例: ContentViewModel.swift, DetailViewModel.swift などのビューモデルクラス。

Supporting Files
プロジェクトに関連するその他のサポートファイル。
例: アセット、設定ファイル、拡張機能、ヘルパークラスなど。

Tests
ユニットテストやUIテストを含むテスト関連のファイル。
例: ViewModelTests.swift, ViewTests.swift など。



## 作り方
- storyboardの設定
    - 元々のビューコントローラーを削除
    - Controllersというグループを作って、xxxxTableViewController.swiftを追加して、UITableViewControllerに準拠させたクラスを作成
    - ストリーボードにTableViewControllerを追加、Edit - Embed - NavigationControllerを追加
    - NavigationControllerのinspectorパネルからIs initial view controllerにチェックを入れて、初期ビューコントローラーに設定
    - TableViewControllerのinspectorパネルのCustomClassから最初に作ったxxxxTableViewControllerを選択する
    - TableViewControllerのTitleを変更する
- xxxxTableViewController.swiftにコード書く


## Bindingとは
- ViewからViewModelのパターン
    - Viewのテキストフィールドに入力されるとViewModelのプロパティが自動で更新される
- ViewModeからViewlのパターン
    - ViewModeのプロパティが変更されるたびにViewのテキストフィールドのテキストが自動で更新される

## WebAPIを使用したMVVMについて
- ビューがビューモデルにアクセスし、ビューモデルがWebServiceやClient層に通信を要求し、WebServiceやClient層が通信を行う
- ネットワーク呼び出しをビューモデル内で直接実行しているわけではないことに注意
