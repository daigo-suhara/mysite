---
title: "Fixing Missing Header Files When Building Neovim on macOS"
date: 2026-03-14
lastmod: 2026-03-14
tags: ["neovim"]
draft: false
showSummary: true
---

## Introduction
trying to build neovim
```shell
make CMAKE_BUILD_TYPE=RelWithDebInfo
```
When I executed
```shell
fatal error: CoreServices/CoreServices.h: No such file or directory
```
An error occurred.

## Cause
(Did you install it on nix?) When using gcc, it seems that it references header files that are incompatible with the latest SDK of macOS.

## Solution
I was able to build it successfully using clang.

If you specify it as an option, please specify the following
```shell
make CMAKE_BUILD_TYPE=RelWithDebInfo CC=clang CXX=clang++
```

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/887cbcf5e5a8414ef420)
