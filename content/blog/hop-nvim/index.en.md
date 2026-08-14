---
title: "Navigate at the Speed of Thought with hop.nvim"
summary: "An introduction to hop.nvim, a Neovim plugin for quickly jumping to any visible location in the editor."
date: 2024-04-29
lastmod: 2024-04-29
tags: ["Vim", "neovim"]
draft: false
showSummary: true
---

## Introduction
This time, I would like to introduce a plugin that I found that is fully compatible with neovim and allows you to move around the screen in all directions like easymotion. This will definitely improve development efficiency!

## How to use (when displaying all words)

#### 1
Suppose the cursor is currently on line 25 and you want to jump to the word methods, which is after line 71 at the bottom of the screen.
![Screenshot 2024-04-28 23.42.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/ddcf943f-e8d8-8cb2-f369-ec8b2dc0e852.png)
#### 2
When you call the command, binding will be assigned to all words, so this time enter jj.
![Screenshot 2024-04-28 23.42.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/2c38763f-deb4-ba4c-5635-7cf66e2922dd.png)
#### 3
Yes. I can now move!
![Screenshot 2024-04-28 23.43.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/5573e05c-d907-a83d-6893-62cdd724524d.png)


## hop.nvim
https://github.com/hadronized/hop.nvim

Easymotion was the only plug-in I knew about, so I used it for a long time, but I thought it was noisy because the buffer was rewritten, so the LSP reacted every time.
hop.nvim seems to be a plugin implemented in the latest neovim based on the concept that UI plugins should not make changes to existing buffers to solve this problem. It's the best.

### Installation method
Same as me, in case of lazy.nvim

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
You can install and configure.
multi_windows is a setting that allows all windows to be searched when several windows are expanded.  There were various other setting items, but basically there didn't seem to be much to change from the defaults.

### Feature introduction
I would like to introduce three commands that I personally find particularly useful.

* ```:HopWord```You can move to where all the words in the buffer are

* ```:HopChar2```You can search and move by specifying two characters.

* ```:HopPattern```You can search in the same way as / in vim. In the standard version, you can only move one by one, but with this one, you can instantly jump to any location from the hit target.

I think it would be quite convenient if you set this area as a key binding.

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/fbc4b338ec844c075d97)
