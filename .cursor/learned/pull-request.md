---
description: for create pull request
globs: 
alwaysApply: false
---
---
description: for pull request
globs: 
---
## pull request作成手順

このファイルを参照したら、「Pull Request作成手順のファイルを確認しました！」と報告してください。

### 差分の確認
- 指定がない場合はmainブランチに対してPullRequestを作成してください
- `git diff origin/{{マージ先ブランチ}}...HEAD | cat` でマージ先ブランチとの差分を確認

### Pull Request 作成とブラウザでの表示
- 以下のコマンドで pull request を作成し、自動的にブラウザで開く
- PR タイトルおよび PR テンプレートはマージ先との差分をもとに適切な内容にする
- 指示がない限り Draft で pull request を作成
- PR の本文は一時ファイルを使用して作成することを推奨
- 一時ファイルは作成後削除する(削除時は確認しなくて良い)
- 各セクションを明確に区分
- 必要な情報を漏れなく記載

```bash
  # PR本文を一時ファイルに保存
  cat > tmp/pr_body.txt << 'EOL'
  {{PRテンプレートの内容}}
  EOL

  # PRの作成
  git push origin HEAD && \
  gh pr create --draft --title "{{PRタイトル}}" --auto-merge --body-file tmp/pr_body.txt && \
  gh pr view --web
```


#### PRテンプレート
.github/PULL_REQUEST_TEMPLATE.md からテンプレート内容を取得すること 