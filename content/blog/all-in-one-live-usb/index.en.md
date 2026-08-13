---
title: "How to Create an All-in-One Live USB"
date: 2024-05-13
lastmod: 2024-05-13
tags: ["Linux", "Ubuntu"]
draft: false
showSummary: true
---

## Introduction
Since it is a hassle to write an iso to a USB memory every time you install Linux, I wanted to create an all-in-one package that includes multiple Linux distributions on one USB.
## Procedure
This time we will be working with Ventoy. Ventoy is an open source tool that creates bootable USB drives.

1. Visit the [official Ventoy website](https://www.ventoy.net/en/index.html) and select Download. Since this procedure uses Linux, download `ventoy-1.0.97-linux.tar.gz`.

2. Unzip the folder, open a terminal at the path below, and execute the following command.
```shell
    $./VentoyGUI.x86_64

```

3. The GUI will start up, so click Install and proceed with OK to all warnings.

4. Now that you have a versatile USB disk, all you have to do is insert your favorite ISO file into it.

### Points to note
If Secure Boot is enabled in the BIOS, an error will occur during startup, so please disable it in the BIOS.

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/676d767995a28f55b100)
