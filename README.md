# Blowfish - Artist Template

## OGP画像

画像指定のないブログ記事には、Hugoで1200×630のOGP画像を自動生成します。
`images`・`featureimage`・記事内のfeature/cover/thumbnail画像があればそちらを優先します。

背景はCanvaから書き出した `assets/og/background.png`（提供ファイル `ogp2.png`）です。
見本 `mihon.png` に合わせ、中央より上に太いタイトル、その下にサイト名を配置します。
URLは表示しません。文字の配置と改行は `layouts/partials/og-image.html` で調整できます。

LINE Seed JPは[Google Fontsの公式リポジトリ](https://github.com/google/fonts/tree/main/ofl/lineseedjp)
からビルド時にTTFを取得します（BoldとRegular、© LY Corporation、SIL Open Font License 1.1）。
フォントの同梱は不要ですが、初回ビルドにはネット接続が必要です。

`layouts/_default/baseof.html` はテーマのhead出力を `social-head.html` に渡すための上書きです。
テーマ更新時にはbaseofの差分を確認してください。

This is a template for the Blowfish Hugo Theme. Feel free to use this repo as a quick way to get started with Blowfish. Please visit [Blowfish's main website](https://github.com/nunocoracao/blowfish) to read the complete documentation.

The template was built using the [Git option](https://nunocoracao.github.io/blowfish/docs/installation/#install-using-git) from Blowfish's installations instructions.

![blowfish logo](https://github.com/nunocoracao/blowfish_artist/blob/main/logo.png?raw=true)
