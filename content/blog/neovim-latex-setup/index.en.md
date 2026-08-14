---
title: "Setting Up a LaTeX Environment for Neovim"
summary: "A guide to setting up Neovim for writing and compiling LaTeX documents."
date: 2024-04-24
lastmod: 2024-09-17
tags: ["Vim", "LaTeX", "neovim"]
draft: false
showSummary: true
---

## Introduction
I built an environment for writing reports using the divine editor neovim (I'm a beginner) using the tex plugin, so I'll summarize it.

## Author's development environment
* M3macbookair(13-inch)
* homebrew installed
* nvim is managed in init.lua

## latexmk setup
First, we will set up latexmk, a useful tool that will perform the troublesome compilation of tex with a single command. A plugin to run tex in vim is required because latexmk runs behind the scenes.
If you don't have the tex environment installed in the first place, install it using the command below.
```shell
brew install mactex
```
If you don't need a GUI, please install it using the command below.
```shell
brew install mactex-no-gui
```
I will pass the path (maybe the GUI version did this during installation?)
The 2024 part will change.
```shell
export PATH=$PATH:/usr/local/texlive/2024/bin/universal-darwin
```
Mactex also includes latexmk, so all you have to do is write the configuration file.
```shell
nvim ~/.latexmkrc
```
Open the configuration file with and write the following content
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
Just this
```shell
latexmk *.tex
```
Just type the command and it will even generate a PDF for you.
There are also options, but since the purpose of this article is not to use commands, I will omit them.

## vimtex setup
From here, we will install the vimtex plugin, which provides useful tex functions to vim/nvim. In my case, I manage plugins with lazy.nvim, so I created vimtex.lua under nvim/lua/plugins,
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
It is written as
The latest version did not work well in my environment, so I specified the previous version, v2.15.
Be careful as it didn't work for some reason at first.
Also, I have specified skim for the viewer, but if you are using preview etc., please change it.
After that, restart nvim and the installation will start, so you can use the minimum functionality.

Open the tex file with nvim and in normal mode
```
<localleader>ll
```
Let's enter . (By default, localleader is \, so if no keymap is set, it is \ll)
Then, the compilation will be done automatically and the viewer should open and the PDF should be displayed. If you edit the code and save it with :w, it will automatically be recompiled, but if you don't like this, you can change it in the settings.

(In the case of skim, go to skim → Settings → Sync and select Check for file changes and Automatically reload. After editing, you can automatically compile and update the display.)

## The end
I wanted to complete as much of my PC work as possible with just vim, so I'm glad that there's one more thing I can do with vim. I also hope that this article will be of help to someone.

### Reference
* https://qiita.com/tdrk/items/16f31e45826c57bce412 (confirmed April 24, 2024)

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/387933f65e7ec13ed8a5)
