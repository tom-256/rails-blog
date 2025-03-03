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
- `{{PRテンプレートを1行に変換}}`の部分はPRテンプレートの内容を`\n`で改行表現した1行の文字列
- 各セクションを明確に区分
- 必要な情報を漏れなく記載

```bash
  # PRの作成
  git push origin HEAD && \
  echo -e "{{PRテンプレートを1行に変換}}" | \
  gh pr create --draft --title "{{PRタイトル}}" --body-file - && \
  gh pr view --web
```

#### PRテンプレート
@PULL_REQUEST_TEMPLATE.md からテンプレート内容を取得すること 
