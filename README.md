# 設問職人 -Question Artisan-

![スクリーンショット 2021-12-06 12 43 22](https://user-images.githubusercontent.com/88603810/144783889-9b8a85ff-54bb-41e7-bfdf-f5f453c3a84d.png)


## サイト概要
オリジナルのクイズ[=設問]を作って解くことができるアプリケーションです。
設問の形式は○×、４択、並び替え、記述があります。今後種類を増やす予定です。

会員登録したユーザはランクが管理でき、
ランクに応じてサイト内で表彰されたり、新しい設問の形式が解放されたりする予定です。
他のユーザの設問を解いたり、自分の設問が解かれたりなどで経験値を貯め、ランクを上げることができます。

受験・試験勉強、備忘録、知識欲の肥やしなどにぜひご利用ください。

### サイトテーマ
以下2つのテーマをコンセプトとします。
1. 誰でも簡単に設問を解いたり作成ができる
2. ランキングで競い合う要素をつくる
3. 他のサイトにはない設問形式を実装する

コンプライアンスの観点から、設問の作成には会員登録が必要ですが、設問を解くだけなら会員登録は不要です。
Railsやjsを用いてビジュアルな設問が作成できたらと思います。

また、応用として、
1. 「設問の良さ」を評価する指標を作り、経験値の配分に影響させる
2. ユーザにおすすめの設問をリコメンドする  

といった機能を実装したいと考えています。

開発に関しては、Rubocop-airbnbに基づいてリーダブルコードを意識して記述します。

### テーマを選んだ理由
* 日常に役立つものを作りたかったため
* 作る方も、使う方も、ためになるものを作りたかったため
* データベースのクエリをいかに効率化するかを追究したいため

### ターゲットユーザ
* 受験生
* 試験勉強をしている人
* クイズ好きな人

### 主な利用シーン
* ひまつぶし
* 学習した内容を、間違いやすい選択肢とともに設問することで試験の対策になる
* 栄誉のためにランキング上位を狙って設問する


## 設計書
* ER図
  * <https://app.diagrams.net/#G1z1cflxcfQGZFKWsAFLgCXhxSzz5LynSB>
* アプリケーション詳細設計
  * <https://docs.google.com/spreadsheets/d/1gt0_7H2x1fZQm0QYGcLEMBrqEkRq0FQXLj_4_9cA7VQ/edit#gid=0>
* WBS
  * <https://docs.google.com/spreadsheets/d/1IBxEHepPj3wupFY0KuenWcz9uhX7Kd_AGxwJ79Z8lqo/edit#gid=1773513600>

## チャレンジ要素一覧
<https://docs.google.com/spreadsheets/d/1QZ0yRBBROrG_x4TVrdtMRbe-Fg3_euMU-0XSwDxjriM/edit#gid=0>

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- 使用検討中です。
