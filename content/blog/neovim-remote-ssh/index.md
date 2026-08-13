---
title: "NeovimでVSCodeみたいにRemoteSSHする方法を見つけた"
date: 2024-10-16
lastmod: 2024-10-16
tags: ["SSH", "Docker", "neovim", "devcontainer", "RemoteSSH"]
draft: false
showSummary: true
---

## プロローグ
vim大好きな自分が，ときたまVScodeを使わざるを得ない時がありました．
それは，サーバー内orコンテナ内のファイルをローカルから直接編集したい時．
vimでもできないかと半年くらい前から思って色々探していましたが見つからず．
でも見つけちゃいました．
その名は[remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim)

## remote-nvimについて
これマジで神です👼
OSはLinux, mac, FreeBSDにサポート対応していて,
ssh, docker-container/image, dev-containerに対応してます．

やってることとしては
- リモート先にneovimをshで自動インストール
- ローカルのオレオレnvimコンフィグをリモートにプッシュ
- リモートのnvimを起動し，ローカルのnvimと接続
- 実質ローカルからオレオレnvimでリモート先のファイルを操作できる．もちろんさまざまなプラグインをほとんど使えるし，他にインストーしたい依存ツールとかも設定で自動インストできる（自分はlazygitとか入れてる）
- しかも使い終わったらちゃんとクリーンアップして，サーバーの環境を汚さない

## インストール
lazy.nvimでプラグインごとにファイル分割してる場合
```lua
return {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = true,
}
```
あとは，githubとか見て各々でconfigのパラメータとか設定していけば使えるようになります．
自分はssh_promptsのEnter passphrase for keyの設定してなくて，ssh接続するときにパスワード入力できひんってなりました．

```lua
local ssh_config = {
			ssh_binary = "ssh",
			scp_binary = "scp",
			ssh_config_file_paths = { "$HOME/.ssh/config" },
			ssh_prompts = {
				{
					match = "Enter passphrase for key",
					type = "secret", -- パスフレーズはシークレットとして扱う
					value_type = "static", -- 毎回新しいパスフレーズを入力するか
					value = "", -- 初期値
				},
				{
					match = "password:",
					type = "secret",
					value_type = "static",
					value = "",
				},
				{
					match = "continue connecting (yes/no/[fingerprint])?",
					type = "plain",
					value_type = "static",
					value = "",
				},
			},
		}
```

## 使い方
デモ動画がgithubに載っています．
起動はRemoteStartコマンド打って，ssh接続の必要項目などをtelescope上で選択していくだけで簡単にできます．

`:RemoteStart`
リモートインスタンスに接続する。リモートneovimサーバーがすでに実行されている場合、ユーザーはローカルクライアントを起動できる

`:RemoteStop`
Neovimサーバーの実行を停止し、セッションを閉じる

`:RemoteInfo`
現在の Neovim 実行で作成されたセッションに関する情報を取得する．進行状況ビューアーを開く

`:RemoteCleanup`
リモートインスタンスからワークスペースおよびリモートneovimセットアップ全体を削除する．また，リモートリソースの構成をクリーンアップする．

`:RemoteConfigDel`
保存されたセッションレコードから、存在しなくなったリモートインスタンスのレコードを削除する．

`:RemoteLog`
プラグインのログファイルを開く．エラーが出たらここ見れば大体わかる．

`:RemoteInfo`
接続に関する情報などが表示される．

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/463ddd15efd8bd993c99)
