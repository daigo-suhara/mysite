---
title: "大学キャンパスシャトルバス予約システム"
date: 2024-04-01
description: "大学キャンパス向けの座席指定シャトルバス予約システム。"
tags: ["Docker", "Nginx", "Python", "Flask", "Jinja2"]
showDate: false
showReadingTime: false
showWordCount: false
---

**2023–2024**

大学から学生団体を通して受託したシャトルバス予約システムです。4台のバスを対象に、各20席の座席指定予約をWebアプリとして実装しました。学生証タッチ認証機器と連携し、予約情報に基づいて乗車可否を判定します。

## Development

システムの稼働基盤としてオンプレミスサーバーを構築し、現地でのセットアップと動作検証を行いました。

![オンプレミスサーバー構築のため、大学に泊まり込みで作業した際の様子](overnight-server-setup.jpg "オンプレミスサーバー構築のため、大学に泊まり込みで作業した際の様子")

## Technology

Docker / Nginx / Python / Flask / Jinja2
