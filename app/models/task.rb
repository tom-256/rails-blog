class Task < ApplicationRecord
  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: ['todo', 'in_progress', 'done'] }
  
  # ステータスのデフォルト値を設定
  after_initialize :set_default_status, if: :new_record?
  
  private
  
  def set_default_status
    self.status ||= 'todo'
  end
end
