---
title: "Go言語: for文の書き方集"
summary: "Goのforを用途別にまとめます．"
date: 2026-10-26
lastmod: 2026-10-26
tags: ["Go", "Tips"]
categories: ["技術"]
series: ["Go Tips"]
draft: false
---

Goで「これどう書くんやっけ」となった時に見返すためのTips．

## 基本形：初期化・条件・更新

```go
for i := 0; i < 5; i++ {
	fmt.Println(i) // 0, 1, 2, 3, 4
}
```

`for 初期化; 条件; 更新` の形．2つ飛ばしなら `i += 2` のように，刻み幅も変えられます．

## 回数だけ指定する（Go 1.22以降）

```go
for range 3 {
	fmt.Println("hello") // 3回表示
}

for i := range 3 {
	fmt.Println(i) // 0, 1, 2
}
```

## while風：条件だけ書く

Goには `while` がないので，`for` に条件だけ書きます．

```go
n := 1
for n < 10 {
	fmt.Println(n) // 1, 2, 4, 8
	n *= 2
}
```

## 無限ループとdo-while風

条件を省略すると無限ループ．終了条件で `break` します．

```go
n := 0
for {
	fmt.Println(n)
	n++
	if n >= 3 {
		break
	}
}
```

`do-while` もありませんが，このようにループの末尾で終了判定すると，最低1回は処理を実行できます．

## スライス・配列をrangeで回す

```go
names := []string{"Go", "Rust", "Python"}

for i, name := range names {
	fmt.Println(i, name)
}

// 値だけ使う
for _, name := range names {
	fmt.Println(name)
}

// 添字だけ使う
for i := range names {
	fmt.Println(i)
}
```

変数を1つだけ書くと，受け取るのは**値ではなく添字**です．値だけ欲しい時は `_, name` と書きます．

### 元の要素を更新する

`range` で受け取る値は要素のコピーなので，元の要素への代入には添字を使います．

```go
nums := []int{1, 2, 3}
for i := range nums {
	nums[i] *= 2
}
fmt.Println(nums) // [2 4 6]
```

ポインタなどを含む要素の場合，コピー先から参照先を変更することはできます．「値がコピーされる」と「参照先も複製される」は別の話です．

## 逆順に回す

```go
names := []string{"Go", "Rust", "Python"}
for i := len(names) - 1; i >= 0; i-- {
	fmt.Println(names[i]) // Python, Rust, Go
}
```

空のスライスなら `i` の初期値が `-1` になり，一度も実行しません．

## mapを回す

```go
scores := map[string]int{"alice": 90, "bob": 80}

for name, score := range scores {
	fmt.Println(name, score)
}

// キーだけ使う
for name := range scores {
	fmt.Println(name)
}
```

mapの走査順は保証されません．順番が必要なら，キーをスライスに集めてソートしてからアクセスします．

## 文字列を回す：runeとbyte

```go
s := "Go言語"

// Unicodeコードポイント単位
for i, r := range s {
	fmt.Printf("%d: %c\n", i, r)
}
// 0: G
// 1: o
// 2: 言
// 5: 語

// byte単位
for i := 0; i < len(s); i++ {
	fmt.Printf("%d: %02x\n", i, s[i])
}
```

文字列への `range` は `rune` 単位ですが，添字はUTF-8の**バイト位置**です．また，結合文字や絵文字では，1つの見た目の文字が複数の `rune` になることがあります．

## channelから受信する

```go
ch := make(chan string, 2)
ch <- "Go"
ch <- "Rust"
close(ch)

for name := range ch {
	fmt.Println(name)
}
```

送信済みの値を受信し終え，channelが閉じられるとループが終了します．閉じられていないchannelは，値がなければ受信待ちになります．この例ではバッファを2つ用意しているので，受信前に2回送信できます．

## continueとbreak

```go
for i := 0; i < 10; i++ {
	if i%2 == 0 {
		continue // 偶数はスキップ
	}
	if i >= 7 {
		break // ループ終了
	}
	fmt.Println(i) // 1, 3, 5
}
```

この形の `for` では，`continue` しても更新処理の `i++` は実行されます．条件だけのループで自分でカウンタを更新する場合は，更新を飛ばさないように注意．

### 入れ子のループから抜ける

```go
Outer:
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			if i+j == 3 {
				break Outer
			}
			fmt.Println(i, j)
		}
	}
```

`break Outer` でラベルの付いた外側のループを終了できます．`continue Outer` なら外側のループの次の反復に進みます．

## イテレータを回す


```go
package main

import (
	"fmt"
	"slices"
)

func main() {
	names := []string{"Go", "Rust", "Python"}
	for i, name := range slices.Backward(names) {
		fmt.Println(i, name) // 2 Python, 1 Rust, 0 Go
	}
}
```

