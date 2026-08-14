---
title: "オールインワンなライブUSBの作り方"
summary: "Ventoyを使い、複数のLinuxディストリビューションを1本のUSBから起動できる環境を構築する方法を紹介します。"
date: 2024-05-13
lastmod: 2024-05-13
tags: ["Linux", "Ubuntu"]
draft: false
showSummary: true
---

## はじめに
LinuxのインストールをするたびにUSBメモリにisoを書き込むのが面倒なので，複数のLinuxディストリビューションを一つのUSBに入れた，オールインワンパッケージを作りたいと思いました．
## 手順
今回はVentoyを使って作業していきます．Ventoyは、ブート可能なUSBドライブを作成するオープンソースツールです。

1. [Ventoy公式ページ](https://www.ventoy.net/en/index.html)にアクセスして，Downloadを選択すると，候補が出てきます．今回はlinuxで作業するのでventoy-1.0.97-linux.tar.gzをダウンロード．

2. フォルダを解凍して，直下のパスでターミナルを開き，以下のコマンドを実行する．
    ```shell
    $./VentoyGUI.x86_64
    ```

3. GUIが立ち上がるので，インストールをクリックして，警告には全てOKで進める．

4. これで万能USBディスクが完成するので，あとはここに，好きなisoファイルをそのまま突っ込むだけ

### 注意点
BIOSのSecure Bootが有効になっていると起動時にエラーが出るのでBIOSで無効化する設定を行なってください

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/676d767995a28f55b100)
