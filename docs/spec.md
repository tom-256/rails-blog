# タスク管理API仕様書

## 概要
このAPIは、タスク管理システムのバックエンドAPIとして機能します。タスクの作成、読み取り、更新、削除（CRUD操作）と、タスクの状態管理を提供します。

## API エンドポイント

### タスク一覧の取得
- **エンドポイント**: `GET /api/v1/tasks`
- **説明**: 登録されているタスクの一覧を取得します
- **クエリパラメータ**:
  - `status`: タスクのステータスでフィルタリング（optional）
  - `page`: ページ番号（デフォルト: 1）
  - `per_page`: 1ページあたりの表示件数（デフォルト: 20）
- **レスポンス**:
  ```json
  {
    "tasks": [
      {
        "id": "task_id",
        "title": "タスクのタイトル",
        "description": "タスクの説明",
        "status": "todo",
        "due_date": "2024-03-20T00:00:00Z",
        "created_at": "2024-03-15T10:00:00Z",
        "updated_at": "2024-03-15T10:00:00Z"
      }
    ],
    "meta": {
      "total_count": 100,
      "current_page": 1,
      "total_pages": 5
    }
  }
  ```

### タスクの作成
- **エンドポイント**: `POST /api/v1/tasks`
- **説明**: 新しいタスクを作成します
- **リクエストボディ**:
  ```json
  {
    "title": "タスクのタイトル",
    "description": "タスクの説明",
    "due_date": "2024-03-20T00:00:00Z"
  }
  ```
- **レスポンス**: 作成されたタスクの情報

### タスクの詳細取得
- **エンドポイント**: `GET /api/v1/tasks/{task_id}`
- **説明**: 指定されたIDのタスク詳細を取得します
- **レスポンス**: タスクの詳細情報

### タスクの更新
- **エンドポイント**: `PUT /api/v1/tasks/{task_id}`
- **説明**: 既存のタスクを更新します
- **リクエストボディ**:
  ```json
  {
    "title": "更新後のタイトル",
    "description": "更新後の説明",
    "status": "in_progress",
    "due_date": "2024-03-25T00:00:00Z"
  }
  ```
- **レスポンス**: 更新されたタスクの情報

### タスクの削除
- **エンドポイント**: `DELETE /api/v1/tasks/{task_id}`
- **説明**: 指定されたIDのタスクを削除します
- **レスポンス**: 204 No Content

## タスクのステータス
タスクは以下のステータスを持ちます：
- `todo`: 未着手
- `in_progress`: 進行中
- `completed`: 完了
- `archived`: アーカイブ済み

## エラーレスポンス
エラーが発生した場合、以下の形式でレスポンスが返されます：
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "エラーメッセージ"
  }
}
```

## 主なエラーコード
- `400 Bad Request`: リクエストパラメータが不正
- `401 Unauthorized`: 認証エラー
- `403 Forbidden`: アクセス権限エラー
- `404 Not Found`: リソースが見つからない
- `422 Unprocessable Entity`: バリデーションエラー
- `500 Internal Server Error`: サーバー内部エラー

## 認証
全てのAPIリクエストには、Bearer認証トークンをヘッダーに含める必要があります：
```
Authorization: Bearer <access_token>
```

## レート制限
- 1時間あたり1000リクエストまで
- レート制限を超えた場合は429 Too Many Requestsを返します
