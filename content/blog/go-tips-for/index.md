---
title: "Go言語: for文の書き方集"
summary: Goのforを用途別にまとめます．
date: 2026-10-26
lastmod: 2026-11-01
tags:
    - Go
categories:
    - 技術
series:
    - Go Tips
draft: false
---

## 基本形

```go
for i := 0; i < 5; i++ {
	fmt.Println(i) // 0, 1, 2, 3, 4
}
```

## 決まった回数だけ繰り返す

```go
for range 3 {
	fmt.Println("hello")
}

// 回数の添字を使う
for i := range 3 {
	fmt.Println(i) // 0, 1, 2
}
```

## 条件を満たす間繰り返す

```go
n := 1
for n < 10 {
	fmt.Println(n) // 1, 2, 4, 8
	n *= 2
}
```

## スライス・配列を回す

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

## スキップ・終了する

```go
for i := 0; i < 10; i++ {
	if i%2 == 0 {
		continue // 次の繰り返しへ
	}
	if i >= 7 {
		break // ループを終了
	}
	fmt.Println(i) // 1, 3, 5
}
```
