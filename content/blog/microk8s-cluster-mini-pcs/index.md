---
title: "ミニPCでmicrok8sクラスタ"
summary: "複数のミニPCへMicroK8sを導入し、Kubernetesクラスタを構築する手順をまとめます。"
date: 2025-06-15
lastmod: 2025-06-15
tags: ["kubernetes", "microk8s"]
draft: false
showSummary: true
---

## 環境
* MAASサーバ
    * IP：192.168.100.50
* node1
    * OS：Ubuntu24.04
    * IP：192.168.100.8
* node2
    * OS：Ubuntu24.04
    * IP：192.168.100.9

## （不要）dockerのインストール
```sh
sudo snap install docker

# docker実行権限付与
sudo addgroup --system docker
sudo adduser $USER docker
```

## microk8sのインストール
```sh
sudo snap install microk8s

# 起動
sudo microk8s start
```
これを２台のサーバーで実行

## クラスタの作成
node1に参加させるためのコマンドを確認します
```sh
sudo microk8s.add-node
```
以下のように出力されるはず
```sh
From the node you wish to join to this cluster, run the following:
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54

Use the '--worker' flag to join a node as a worker not running the control plane, eg:
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54 --worker
```

node2でクラスタに参加します
```sh
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54
```
少し待つと，
Successfully joined the cluster.
と出力されてクラスタに参加できました

```sh
# エイリアス作成
sudo snap alias microk8s.kubectl kubectl

sudo microk8s.kubectl get nodes
```
とコマンドを打って確認すると
```sh
NAME    STATUS   ROLES    AGE   VERSION
node1   Ready    <none>   15m   v1.32.3
node2   Ready    <none>   77s   v1.32.3
```
しっかりノードが登録されていますね

## argoCDインストール
```
#　ネームスペースの作成
sudo kubectl create namespace argocd

# 公式マニフェストでデプロイ
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# サービスポート確認
sudo kubectl get svc argocd-server -n argocd

# パスワード確認
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## 参考
* https://devops-blog.virtualtech.jp/entry/20220322/1647924202

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/6e666176f2a4ad5df297)
