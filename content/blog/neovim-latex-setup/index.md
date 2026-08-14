---
title: "Neovim用のLatex環境を整えてみた"
summary: "NeovimでLaTeX文書を執筆・コンパイルするための開発環境を構築する手順を紹介します。"
date: 2024-04-24
lastmod: 2024-09-17
tags: ["Vim", "LaTeX", "neovim"]
draft: false
showSummary: true
---

## はじめに
神エディタneovim（初心者です）で，texプラグインを使ってレポートを執筆するための環境構築を行ったので，まとめておきます．

## 筆者の開発環境
* M3macbookair(13-inch)
* homebrewインストール済み
* nvimはinit.luaで管理

## latexmkのセットアップ
まずは，texの面倒なコンパイルをコマンド一発で行ってくれるという便利ツールlatexmkを設定していきます．vimでtexを動かすプラグインはlatexmkが裏で動くので必須です．
そもそもtex環境入ってないって場合は以下のコマンドでインストールしましょう．
```shell
brew install mactex
```
GUIはいらねーって人は下記のコマンドでインストールしてください
```shell
brew install mactex-no-gui
```
パスを通してあげます（gui版はインストール時にやってくれてたかも？）
2024の部分は変わってきます．
```shell
export PATH=$PATH:/usr/local/texlive/2024/bin/universal-darwin
```
mactexにはlatexmkも入っているので，あとは設定ファイル書くだけで使えちゃいます．
```shell
nvim ~/.latexmkrc
```
で設定ファイルを開いて，以下の内容を記述します
```sh:~/.latexmkrc
#!/usr/bin/perl
$latex = 'platex -guess-input-enc -src-specials -interaction=nonstopmode -synctex=1';
$latex_silent = 'platex -interaction=batchmode';
$dvips = 'dvips';
$bibtex = 'pbibtex';
$makeindex = 'mendex -r -c -s jind.ist';
$dvi_previewer = 'start dviout'; # -pv option
$dvipdf = 'dvipdfmx %O -o %D %S';
if ($^O eq 'darwin') {
    #$pdf_previewer = 'open -a Preview %S';   #プレビュー使うならこっち
    $pdf_previewer = 'open -a Skim';          #skimはこっち
} elsif ($^O eq 'linux') {
    $pdf_previewer = 'evince';
}
$preview_continuous_mode = 1;
$pdf_mode = 3;
$pdf_update_method = 4;
```
これだけで
```shell
latexmk *.tex
```
とコマンドを打つだけでpdfの生成までやってくれます．
オプションもありますが，今回はコマンドを使うことが目的ではないので割愛します．

## vimtexのセットアップ
ここからはvim/nvimにtexの便利機能を与えてくれるvimtexプラグインをインストールしていきます．僕の場合はlazy.nvimでプラグインを管理しているので，nvim/lua/plugins下にvimtex.luaを作成し，
```lua:vimtex.lua
return {
    "lervag/vimtex",
    lazy = false,
    tag = "v2.15",
    init = function()
        vim.g.vimtex_view_method = 'skim'
    end
}
```
と記述します．
僕の環境では最新版はうまく動いてくれなかったので，以前のv2.15を指定しています．
初めなぜか動かないってなったので注意
また僕はビューアーにはskimを指定していますが，プレビューなどを使用している人は変更しておいてください．
あとは，nvimを再起動すればインストールが始まるので最低限の機能が使える用になります．

nvimでtexファイルを開き，ノーマルモードで
```
<localleader>ll
```
と入力しましょう．（デフォルトでlocalleaderは\なので，キーマップ設定してない場合は\llです）
すると，自動的にコンパイルが行われるとともに，ビューアーが開いてpdfが表示されるはずです．コードを編集した場合:wで保存すると勝手に再コンパイルされますが，これが嫌な人は設定で変えれます．

（skimの場合，skim→設定→同期から，ファイルの変更をチェックと自動的にリロードするを選択しておくことで，編集したら自動でコンパイルして表示の更新までできちゃいます．）

## おわり
vimだけでpcの作業をできるだけ完結したいと思っていたので，またひとつvimでできることが増えて嬉しいです．またこの記事が誰かの一助になれば幸いです．

### 参考
* https://qiita.com/tdrk/items/16f31e45826c57bce412 (2024年4月24日確認済み)

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/387933f65e7ec13ed8a5)
