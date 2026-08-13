---
title: "【 本番向け】terraformを使ってdifyをGCP上にセルフホスティングする"
date: 2025-05-24
lastmod: 2025-05-24
tags: ["Terraform", "Dify"]
draft: false
showSummary: true
---

## 1. はじめに
AIアプリがWEBUI上で簡単に作れるdifyを，terraformを使用してGoogle Cloud Platform(gcp)上でセルフホスティングする方法を記述します．

### この記事でできること
- terraformを用いたgcp上でのdifyのセルフホスティング

### この記事の対象者
- AIアプリを簡単に外部公開したい方
- difyをローカルだけでなく，クラウドで運用したい方

### 動作環境
- OS バージョン
    - MacOS Sequoia 15.5

## 事前準備
### リポジトリのクローン
difyをgcpでホスティングする場合，クラウド上でのインフラ構築などを自動化するterraformの設定ファイルを公開してくれている以下のリポジトリがあるのでクローンします．

```sh
git clone https://github.com/DeNA/dify-google-cloud-terraform
```

### パッケージのインストール
#### terraformのインストール
```sh
brew install terraform
```

#### google cloud sdkのインストール
```sh
brew install --cask google-cloud-sdk
```

### gcpプロジェクトの作成
コンソールから任意の名前でプロジェクトを作成します．
詳細は割愛します．

### cliからgcpにログイン
```sh
gcloud auth login
```
コマンド入力後webページが開くのでログインします．

## tfvars保管用バケットの作成
terraformの状態をクラウドで管理するためのストレージを作成します
GCPコンソールからbucketsを選択します．
任意の名前でバケットを作成しておいてください

## ファイルの修正
先ほどクローンしてきたリポジトリを修正して，自分用にカスタムします．
### gitignoreの修正
機密情報をリモートに上げないように，gitignoreに追記します
```text:.gitignore
terraform.tfvars
```

* terraform/environments/dev
を
* terraform/environments/prod
という名前でコピーします．

### provider.tfの修正
先ほど作成したバケットをterraformの状態管理に適用します
```diff_terraform:provider.tf
terraform {
  backend "gcs" {
+   bucket = "<バケットの名前>"
    prefix = "dify"
  }
}
```

### tfvarsの修正
コピーしたprod内のterraform.tfvarsを修正します
keyについては，

```sh
openssl rand -base64 42
```
を実行して，作成するといいでしょう

```diff_terraform:terraform.tfvars
+ project_id = "例：dify-sample-app"
+ region = "例：asia-northeast1"
+ plugin_daemon_key = "<opensslコマンドで作成>"
+ plugin_dify_inner_api_key = "<opensslコマンドで作成>"
```

## デプロイ
ここまできたらいよいよGCPにデプロイします

### terraform初期化
```sh
cd terraform/environments/prod
terraform init
```

### Artifact Registry リポジトリを作成
```sh
terraform apply -target=module.registry
```

### コンテナイメージをビルド＆プッシュ
```sh
cd ../../..
sh ./docker/cloudbuild.sh <project-id> <region>
```

### terraformプランニング
```sh
cd terraform/environments/dev
terraform plan
```

### terraform適用
```sh
terraform apply
```

## 注意
terraformの適用中にapi関連のエラーが発生することがあります，その場合はエラー文に従って，必要なapiを有効化してください．
GCPコンソールから有効化ボタン押すだけです

## 参考資料
<!--

https://qiita.com

[リンク1](https://qiita.com)
-->

https://github.com/DeNa/dify-google-cloud-terraform


<!--
## おわりに・まとめ
どちらかを書きます。あってもなくても良いです。
-->

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/ff3e627c882adcb6c814)
