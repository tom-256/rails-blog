---
description: AIエージェント用Gitコマンド実行ガイドライン
globs: 
alwaysApply: false
---
# AIエージェント用Gitコマンド実行ガイドライン

このファイルを参照したら、「AIエージェント用Gitコマンド実行ガイドラインを参照しました」と報告してください。


## 基本原則

1. **インタラクティブコマンドの回避**
   - AIエージェントはインタラクティブな入力を必要とするコマンドを実行できません
   - エージェントはプロンプトに応答できないため、これらのコマンドは停止します

2. **非インタラクティブモードの強制**
   - すべてのGitコマンドには`--no-pager`オプションを使用する
   - カラー出力を無効にするため`-c color.ui=false`または`--no-color`を使用する

3. **出力形式の標準化**
   - 構造化された出力形式を使用する（JSON、CSV、タブ区切りなど）
   - 人間向けの複雑なフォーマットは避ける

4. **mainブランチにはプッシュしない**
   - mainブランチにはプッシュしないこと

## 推奨コマンド形式

### 状態確認系コマンド

```bash
# リポジトリの状態確認
git -c color.status=false --no-pager status --porcelain

# ブランチ一覧の取得
git --no-pager branch --no-color

# コミット履歴の取得
git --no-pager log --no-color --pretty=format:"%h|%an|%ad|%s" --date=short -n 10
```

### 差分確認系コマンド

```bash
# 変更ファイル名のみ取得
git --no-pager diff --name-only

# 変更の統計情報取得
git --no-pager diff --stat --no-color

# 数値統計情報（追加/削除行数）
git --no-pager diff --numstat
```

### コミット操作系コマンド

```bash
# 安全なコミット操作（メッセージは引数で指定）
git add . && git commit -m "コミットメッセージ" --no-verify

# 直前のコミットメッセージ変更（インタラクティブエディタを回避）
git commit --amend -m "新しいコミットメッセージ" --no-edit --no-verify
```

## エラー処理

1. タイムアウト設定を適切に行う
2. エラー出力も標準出力と同様に処理できるようにする
3. 実行前に`git rev-parse --is-inside-work-tree`でリポジトリであることを確認する