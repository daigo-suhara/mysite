---
title: "ミニPC 3台とラズパイで始める！MAASとOpenstackで作る本格お家クラウド構築録"
date: 2025-06-29
lastmod: 2025-06-29
tags: ["Cloud", "RaspberryPi", "openstack", "サーバー", "MAAS"]
draft: false
showSummary: true
---

![IMG_3491.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/894aaf8c-ae60-40f8-8836-382fcd8209f4.png)
## はじめに
「クラウド破産を気にせずインフラを触り倒したい…」「自宅にもっとパワフルで柔軟な開発環境が欲しい…」
そんな思いから、自宅にプライベートクラウドを構築することにしました。

この記事では、3台のミニPCと1台のRaspberry Piを使って、OSのプロビジョニングからOpenStackのデプロイまでを自動化した、本格的なお家クラウドの構築手順を記録します。


## 構成紹介: 今回のお家クラウドを支える機材たち

#### 🖥️ サーバー群

| 役割 | 機材 | 台数 | スペック |
| :--- | :--- | :--- | :--- |
| **OpenStackノード** <br> (Control x1, Compute x2) | ミニPC | 3台 | **CPU**: Intel Processor N150 <br> **Memory**: 16GB <br> **Storage**: 512GB NVMe SSD <br> **NIC**: 1ポート |
| **MAASサーバー** <br> (OSプロビジョニング) | Raspberry Pi 4 | 1台 | 8GB モデル |

#### 💡 NICの追加について
OpenStack (Kolla-Ansible) の標準的な構成では、コントロールノードに管理用と外部接続用の2つのネットワークインターフェースが必要です。
今回使用したミニPCはNICが1ポートだったため、コントロールノード用の1台にだけ、USB接続のNICを1つ追加しました。

#### 🌐 ネットワーク機器

| 役割 | 機材 | 備考 |
| :--- | :--- | :--- |
| **ルーター** | Ubiquiti EdgeRouter X | `OpenWrt` ファームウェアを使用 |
| **スイッチングハブ** | TP-Link TL-SG605 | 5ポート・マネージメントスイッチ |

### なぜこの構成？
MAAS on Raspberry Pi: Raspberry Piは省電力で常時起動させておくMAASサーバーに最適です。MAASを導入することで、ミニPCのOSインストールや再設定が完全に自動化され、「サーバーを物理的なモノとしてではなく、APIで操作できるリソース」として扱えるようになります。

ミニPC: 省スペースかつ、近年のモデルは仮想化基盤として十分な性能を持っています。3台用意することで、OpenStackのマルチノード構成を試すことができます。

## STEP 1: MAASによるOSプロビジョニング自動化
まずは、お家クラウドの心臓部となるMAASをRaspberry Piにセットアップし、ミニPCたちを支配下に置きます。

1. Raspberry PiにMAASをインストール
Raspberry PiにはUbuntu Serverをインストールしておきます。
その後、SSHでログインし、MAASをインストールします。

2. MAASの初期設定
Web UIにアクセスし、初期設定を進めます。

3. ミニPCのPXEブート設定とOSデプロイ
次に、ミニPC側の準備です。

各ミニPCのBIOS/UEFI設定画面を開き、Network Boot (PXE Boot) を有効にします。

起動順序をPXE Bootが最優先になるように変更します。

設定を保存してミニPCを起動すると、MAASのDHCPサーバーからIPアドレスを取得し、ネットワークブートが開始されます。

しばらくすると、MAASのWeb UIのMachinesタブに、新しいマシンがNewステータスで表示されるはずです。

![スクリーンショット 2025-06-29 10.45.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/4350d32b-369b-4583-b909-ee434d97cd38.png)

MAASは自動でマシンのハードウェア情報（CPU, メモリ, ストレージ等）を収集（Commissioning）します。Commissioningが完了したら、マシンを選択してAcquireし、最後にDeployボタンを押して Ubuntu 24.04 のデプロイを開始します。

この操作を3台のミニPCすべてで行います。
デプロイが完了すると、MAASが払い出したIPアドレスに対して、先ほど登録したSSHキーでパスワードレスログインができるようになっているはずです。最高ですね！

## STEP 2: Kolla-AnsibleによるOpenStackマルチノード構築
OSの準備が整ったので、いよいよOpenStackを構築していきます。
コンテナベースでOpenStack環境を構築できるKolla-Ansibleを使い、マルチノード構成に挑戦します。

control01: コントロールノード & etc

compute01: コンピュートノード

compute02: コンピュートノード

### Horizon (ダッシュボード) へのアクセス
ブラウザで http://<kolla_internal_vip_address> にアクセスすると、OpenStackのダッシュボード（Horizon）が表示されるはずです。 /etc/kolla/passwords.yml に記載されているkeystone_admin_passwordでログインできます。

![スクリーンショット 2025-06-29 10.49.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/081031ba-68f8-4374-8e91-3b376662e6be.png)

## 🚀 今後の展望: MagnumでKubernetesクラスタを！
OpenStackという強力なIaaS基盤が手に入りました。
次のステップとして、OpenStackのコンテナオーケストレーションエンジンサービスである Magnum を利用して、オンデマンドでKubernetesクラスタを構築できる環境を目指します。

## おわりに
今回は、MAASとKolla-Ansibleという強力なツールを組み合わせることで、OSのプロビジョニングからOpenStackのデプロイまでを自動化したお家クラウドの構築手順をご紹介しました。

物理サーバーのセットアップが驚くほど楽になり、オンプレ環境でのインフラをコードで管理する楽しさとパワフルさを実感できました。
ミニPCとRaspberry Piで、皆さんも自分だけのクラウドを手に入れてみてはいかがでしょうか？

この記事が、お家クラウドに挑戦する誰かの助けになれば幸いです。

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/add121ce1a28105e441e)
