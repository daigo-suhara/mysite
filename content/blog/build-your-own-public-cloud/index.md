---
title: "パブリッククラウド自作入門１"
date: 2026-06-14
lastmod: 2026-06-16
tags: ["AWS", "Azure", "自宅サーバー", "GoogleCloud"]
draft: false
showSummary: true
---

## はじめに
AWS，Azure，GoogleCloudなどパブリッククラウドはすごく便利ですが，個人で使うには高いですよね．（貧乏学生にはきちぃ）
一生無料で，使い放題なクラウドがほしいな〜

**せや自分で作ればいいやん！**

ということでパブリッククラウドを自作してみました

システム構成は大体下図の通りです（図Gemini作）．
![Gemini_Generated_Image_grq25ugrq25ugrq2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/197f94c5-0efb-46ce-a6ae-ff7697253dcb.png)

##### 宣伝
自作クラウドのコンテナサービス（ECS風）で運用しているポートフォリオサイトです
https://daigo-suhara.com

## フェーズ1：kubernetesクラスタ自動構築化
基盤にはkubernetesを採用することにしました．
しかしベアメタルにクラスタ構築するのめんどいなーということで自動的にクラスタ構築してくれるようにしました．

具体的には，Tinkerbellというソフトウェアを使用しています．これによりストレージ空っぽ，電源OFFの状態から，クラスタ構築に必要最低限なパッケージ（kubeadmなど）のみ含んだOSが勝手にインストールされます．
（Tinkerbell：ベアメタルにipxe経由でOSや初期設定を自動的にプロビジョニングしてくれる）
さらにClusterAPI Provider Tinkerbellを使用することで，OSプロビジョニング後のクラスタ構築作業も自動化してくれます．

自分はこれを，ノートPCにmicrok8sで作ったクラスタの上にargocdをインストして，argocdリソースとしてtinkerbell環境を構築しています．


## フェーズ2：クラウドコアシステムの作成
まず現状ですが，
* 認証系（IAM的な）
* テナント
* コンテナサービス(ECS)
* 仮想マシン(EC2)
* WEBコンソール
* API

が作成できています．

それぞれの内部システムはgrpcサーバとして切り離されていて，GitHub Actionsでコンテナ化してociレジストリにPushしたものを，ArgoCDが呼び出します．
（＊APIはFastAPI，WEBコンソールはReact製です）

### コンテナサービスについて
基盤はknativeで動いています．それをFastAPIからの指示に基づいてGo製のシステムで操作しています．

オートスケールやコンテナイメージURLの指定などができます．ソースコードからの継続デプロイ機能はまだ開発できていません．

また，ドメインマッピング機能もあるので，<サービスID>.drkatana.comという名前で公開URLもつきますし，CNAMEでカスタムドメインも設定できます．
![スクリーンショット 2026-06-14 13.00.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/686e5bf0-62a4-4811-bfc8-96f9322944b0.png)
![スクリーンショット 2026-06-14 13.05.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/2f059d92-90cd-484e-b972-d201de4b2171.png)



### 仮想マシンについて
基盤はkubevirtで動いています．ubuntu，fedora，debianなどのテンプレートの他，カスタムociイメージを指定することができます．コア数やメモリ数の指定と，コンソール画面からの操作ができます．
コンソール画面はwebsocketとxterm.jsで実装しています．
![スクリーンショット 2026-06-14 13.01.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/30ee4cf5-185a-4353-b9a4-633cbe577ec6.png)


## おわりに
自分用クラウドとしてはOpenStackなどのOSSを使うと楽ですが，自分で１から作るというのは勉強も兼ねつつ，つい時間を忘れて徹夜してしまうくらい楽しむことができたので，ぜひクラウド自作erが増えるといいなと思いました．

## 謝辞
今回開発作業にあたり，私の無茶なアーキテクチャを実装するコーディング作業の多くを担当してくださったCodexに感謝を表します．

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/5fddc494ae53d8967656)
