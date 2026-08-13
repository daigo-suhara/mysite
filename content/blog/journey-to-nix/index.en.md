---
title: "Escaping Environment Setup Hell: My Journey to Nix"
date: 2026-04-10
lastmod: 2026-04-10
tags: ["環境構築", "dotfiles", "nix"]
draft: false
showSummary: true
---

## What is nix?
* A savior that frees us from the troubles of building an environment (works natively, not in a virtual environment like docker)
* Super useful package manager (and configuration language)
* The OS environment (including non-development environments) can be coded to create the exact same environment on any machine.

## Time series
1. Know apt
I learned about the existence of package managers when I used Ubuntu for the first time.
2. Learn about homebrew
I learned that there is a package manager not only for Linux but also for Mac.
3. Know docker
I learned that you can easily reproduce environments by using containers.
4. Know dotfiles
I learned that there is a concept of centrally managing config files that were previously managed manually using git.
5. Know nix
I came across this when I wanted to switch dotfiles for each machine.

### Appendix
* My dotfiles: https://github.com/daigo-suhara/dotfiles

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/9c06ef05bd805e9ef218)
