class Task < ApplicationRecord
  # タイトルは必須
  validates :title, presence: { message: "は必須です" },
                    length: { maximum: 100, message: "は100文字以内で入力してください" }

  # 説明文は1000文字まで
  validates :description, length: { maximum: 1000, message: "は1000文字以内で入力してください" },
                          allow_blank: true

  # ステータスは必須かつ、指定された値のいずれかであること
  validates :status, presence: { message: "は必須です" },
                     inclusion: {
                       in: %w[todo in_progress done],
                       message: "は 'todo', 'in_progress', 'done' のいずれかである必要があります"
                     }

  # 期限日は未来の日付または空欄であること（過去の日付は不可）
  validate :due_date_cannot_be_in_the_past, if: -> { due_date.present? }

  # ステータスのデフォルト値を設定
  after_initialize :set_default_status, if: :new_record?

  private

  # ステータスのデフォルト値として"todo"を設定
  def set_default_status
    self.status ||= "todo"
  end

  # 期限日が過去の日付でないことを検証
  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "は今日以降の日付を設定してください") if due_date < Date.current
  end
end
