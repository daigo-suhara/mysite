POST_NAME := $(word 2,$(MAKECMDGOALS))

.PHONY: help post serve build $(POST_NAME)

ifneq ($(POST_NAME),)
$(POST_NAME):
	@:
endif

help:
	@echo "make post my-new-post  新しい記事を作成"
	@echo "make serve             下書きを含めてプレビュー"
	@echo "make build             サイトをビルド"

post:
	@test -n "$(POST_NAME)" || { echo "記事名を指定してください: make post my-new-post"; exit 1; }
	hugo new content "blog/$(POST_NAME)/index.md"
	@echo "作成しました: content/blog/$(POST_NAME)/index.md"

serve:
	hugo server -D

build:
	hugo --quiet
