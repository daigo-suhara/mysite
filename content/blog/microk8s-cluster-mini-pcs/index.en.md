---
title: "Building a MicroK8s Cluster with Mini PCs"
summary: "A practical guide to installing MicroK8s across multiple mini PCs and forming a Kubernetes cluster."
date: 2025-06-15
lastmod: 2025-06-15
tags: ["kubernetes", "microk8s"]
draft: false
showSummary: true
---

## Environment
* MAAS server
    *IP: 192.168.100.50
*node1
    *OS: Ubuntu24.04
    *IP: 192.168.100.8
*node2
    *OS: Ubuntu24.04
    *IP: 192.168.100.9

## (Unnecessary) Installing docker
```sh
sudo snap install docker

# docker実行権限付与
sudo addgroup --system docker
sudo adduser $USER docker
```

## Installing microk8s
```sh
sudo snap install microk8s

# 起動
sudo microk8s start
```
Run this on two servers

## Create a cluster
Check the command to join node1
```sh
sudo microk8s.add-node
```
The output should be as below
```sh
From the node you wish to join to this cluster, run the following:
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54

Use the '--worker' flag to join a node as a worker not running the control plane, eg:
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54 --worker
```

Join the cluster on node2
```sh
microk8s join 192.168.100.8:25000/3039a88b56eaa8aa4b37fcc6ee281bdf/f8d2731d0c54
```
After waiting a while,
Successfully joined the cluster.
I was able to join the cluster with the output

```sh
# エイリアス作成
sudo snap alias microk8s.kubectl kubectl

sudo microk8s.kubectl get nodes
```
If you check by typing the command
```sh
NAME    STATUS   ROLES    AGE   VERSION
node1   Ready    <none>   15m   v1.32.3
node2   Ready    <none>   77s   v1.32.3
```
The node is properly registered.

## argoCD installation
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

## Reference
*https://devops-blog.virtualtech.jp/entry/20220322/1647924202

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/6e666176f2a4ad5df297)
