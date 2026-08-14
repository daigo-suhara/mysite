---
title: "思考のスピードで飛び回れるNvimプラグインhop.nvimの紹介"
summary: "画面内の任意の位置へ素早く移動できるNeovimプラグイン、hop.nvimの使い方を紹介します。"
date: 2024-04-29
lastmod: 2024-04-29
tags: ["Vim", "neovim"]
draft: false
showSummary: true
---

## はじめに
今回はneovim完全対応でeasymotionのように，画面を縦横無尽に飛び回れるプラグインを見つけたので紹介します．これがあれば開発効率上がること間違いなし！

## 使い方（単語全表示の場合)

#### 1
現在カーソルが25行にあり画面一番下71行の後ろにあるmethodsという単語に飛びたいとします
![スクリーンショット 2024-04-28 23.42.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/ddcf943f-e8d8-8cb2-f369-ec8b2dc0e852.png)
#### 2
コマンドを呼び出すと，全ての単語にバインドが割り振られるので，今回はjjと入力します
![スクリーンショット 2024-04-28 23.42.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/2c38763f-deb4-ba4c-5635-7cf66e2922dd.png)
#### 3
はい．もう移動できました！
![スクリーンショット 2024-04-28 23.43.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/5573e05c-d907-a83d-6893-62cdd724524d.png)


## hop.nvim
https://github.com/hadronized/hop.nvim

自分はこの手のプラグインはeasymotionしか知らなかったので，ずっと使っていたのですがバッファが書き換わるのでLSPがいちいち反応してうるさいなと思っていました．
hop.nvimは，この問題を解決するためにUIプラグインは既存のバッファに変更を加えるべきではないというコンセプトをもとに最新のneovimに実装したプラグインのようです．最高だ．

### インストール方法
僕と同じ，lazy.nvimの場合は

```lua:hop.lua
return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    require("hop").setup {
      multi_windows = true,
    }
  end,
  keys = {
    {mode = "", "<leader>s", "<cmd>HopChar<CR>", desc = "説明"},
  }
}
```
でインストールと設定ができます．
multi_windowsはウィンドウをいくつか広げているときに，全てのウィンドウが検索対象にすることができる設定です．  他にも色々設定項目ありましたが，基本的にはデフォルトから変えることはあまりなさそうでした．

### 機能紹介
個人的に特に便利だと思うコマンドを３つ紹介します．

* ```:HopWord```
バッファ内の全ての単語がある場所に移動できます

* ```:HopChar2```
2文字を指定して，検索をかけて移動することができます

* ```:HopPattern```
vim標準の/と同じように検索をかけることができます．標準では１つずつしか移動できないのに対して，こっちはヒットした対象から任意の箇所に一瞬で飛べちゃう．

この辺りをキーバインディングに設定しておけばかなり便利だと思います．

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/fbc4b338ec844c075d97)
