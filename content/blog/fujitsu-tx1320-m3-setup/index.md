---
title: "TX1320 M3（富士通業務用サーバ）の設定でハマったこと"
summary: "Fujitsu TX1320 M3へのProxmox導入時にディスクが認識されない問題と、その解決方法を紹介します。"
date: 2026-04-19
lastmod: 2026-04-22
tags: ["サーバー", "tx1320m3"]
draft: false
showSummary: true
---

## はじめに
富士通の業務用サーバをお出迎えしたのですが，proxmoxをインストールしたいのになぜかディスクが認識されない？となったので解決した方法を一応メモしておきます．

## 原因
IOMMUが物理アドレスと仮想アドレスの再マッピングを厳格に行うため、一部のMegaRAIDコントローラが期待するDMA転送と衝突するとかなんとか
ちなみにOSによってはいけるっぽい

## 解決策
proxmoxのインストール時に，インストール方法を選択する画面でeキーを押してgrubの編集画面に飛び，**linux**と書かれてる行の末尾にスペースを空けて，
```
intel_iommu=off
```
と追記して，F10で確定すると普通にインストールできた．

もしくは，UEFIからAdvanced -> CPU Configuration -> VT-dをDisabledにすることで永続的にiommuをオフにできます．（この後MegaRAIDのキャッシュエラーが出たのでUEFIからhealth checkみたいなとこでXキー押したら治った）

### RAID使いたくない場合（ディスクを単体で使いたい場合）
JBOD Modeに切り替えることでディスクがそのまま認識される

UEFIにて
Advanced -> AVAGO MegaRAID -> Main Menu -> Controller Manegement -> Advanced Controller Properties -> JBOD ModeをEnabledに変更 -> Apply Changes

### 試したこと1
マザボからRAIDカードをぶち抜いた

![取り外したRAIDカード](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3777414/45043655-0c10-4649-943b-271b0fb4059f.jpeg)
{style="width:320px; margin-inline:auto;"}

hddケースのSASをマザボに挿しても認識しないみたいで，SAS->SATAの変換が必要なので，どっちにしろ認識はしない（RAIDキャッシュのエラーは無くなったけど）．

### 試したこと2
Raid0をストレージの数（２枚）組んだ．

UEFIにて
Advanced -> AVAGO MegaRAID -> Configure -> Create Virtual Drive
あとはraid0を選択してdriveを一つだけ選択して，applyを2回やる

しかしダメだった

## 付録（エラー画面）
### Windows Serverが入ったRAIDをクリーンしてからずっと出るエラー
```sh
L2/L3 Cache error was detected on the RAID controller.
Please contact technical support to resolve this issue.
Press 'X' to continue or else power off the system, replace the controller and reboot.
Enter Your Input Here:
```

### OSインストールしようとした時のエラー
```sh
[   78.431957] megaraid_sas 0000:01:00.0: megasas_get_ld_map_info DCMD timed out, RAID map is disabled
[   78.433510] megaraid_sas 0000:01:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
[   78.434796] megaraid_sas 0000:01:00.0: INIT adapter done
Timed out for waiting the udev queue being empty.
Begin: Loading essential drivers ... [  121.164801] raid6: avx2x4   gen() 41207 MB/s
[  121.181805] raid6: avx2x2   gen() 40382 MB/s
[  121.198804] raid6: avx2x1   gen() 32882 MB/s
[  121.199111] raid6: using algorithm avx2x4 gen() 41207 MB/s
[  121.215805] raid6: .... xor() 13554 MB/s, rmw enabled
[  121.216100] raid6: using avx2x2 recovery algorithm
[  121.217759] xor: automatically using best checksumming function   avx
[  121.219041] async_tx: api initialized (async)
done.
Begin: Running /scripts/init-premount ... Timed out for waiting the udev queue being empty.
done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... Begin: Waiting up to 180 secs for BOOTIF to become available ... _

```

---

[Qiitaで元の記事を読む](https://qiita.com/daigo-suhara/items/6913be2e94a215dbbcc3)
