---
title: "macosでneovimのbuild時にヘッダファイルが見つからないエラー"
date: 2026-03-14
lastmod: 2026-03-14
tags: ["neovim"]
draft: false
showSummary: true
---

## はじめに
neovimをビルドしようと
```shell
make CMAKE_BUILD_TYPE=RelWithDebInfo
```
を実行したところ
```shell
fatal error: CoreServices/CoreServices.h: No such file or directory
```
というエラーが出た．

## 原因
（nixでインストールした？）gccを使用していると，macOSの最新SDKと互換性のないヘッダーファイルを参照してしまうらしい

## 解決策
clangを使用すると，無事にビルドできた

オプションで指定するなら下記
```shell
make CMAKE_BUILD_TYPE=RelWithDebInfo CC=clang CXX=clang++
```

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/887cbcf5e5a8414ef420)
