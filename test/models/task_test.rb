require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # title関連のテスト
  test "should not save task without title" do
    task = Task.new(status: "todo")
    assert_not task.save, "タイトルなしでタスクが保存されました"
    assert_includes task.errors[:title], "は必須です"
  end

  test "should not save task with too long title" do
    # 101文字のタイトルを作成
    long_title = "a" * 101
    task = Task.new(title: long_title, status: "todo")
    assert_not task.save, "タイトルが長すぎるタスクが保存されました"
    assert_includes task.errors[:title], "は100文字以内で入力してください"
  end

  # description関連のテスト
  test "should not save task with too long description" do
    # 1001文字の説明を作成
    long_description = "a" * 1001
    task = Task.new(title: "Test Task", description: long_description, status: "todo")
    assert_not task.save, "説明が長すぎるタスクが保存されました"
    assert_includes task.errors[:description], "は1000文字以内で入力してください"
  end

  test "should save task with blank description" do
    task = Task.new(title: "Test Task", description: "", status: "todo")
    assert task.save, "説明が空のタスクが保存できませんでした"
  end

  # status関連のテスト
  test "should not save task without status" do
    task = Task.new(title: "Test Task", status: nil)
    assert_not task.save, "ステータスなしでタスクが保存されました"
    assert_includes task.errors[:status], "は必須です"
  end

  test "should not save task with invalid status" do
    task = Task.new(title: "Test Task", status: "invalid_status")
    assert_not task.save, "無効なステータスでタスクが保存されました"
    assert_includes task.errors[:status], "は 'todo', 'in_progress', 'done' のいずれかである必要があります"
  end

  # due_date関連のテスト
  test "should not save task with past due date" do
    past_date = Date.current - 1.day
    task = Task.new(title: "Test Task", status: "todo", due_date: past_date)
    assert_not task.save, "過去の期限日でタスクが保存されました"
    assert_includes task.errors[:due_date], "は今日以降の日付を設定してください"
  end

  test "should save task with future due date" do
    future_date = Date.current + 1.day
    task = Task.new(title: "Test Task", status: "todo", due_date: future_date)
    assert task.save, "未来の期限日でタスクが保存できませんでした"
  end

  test "should save task with no due date" do
    task = Task.new(title: "Test Task", status: "todo", due_date: nil)
    assert task.save, "期限日なしでタスクが保存できませんでした"
  end

  # 基本動作のテスト
  test "should save task with valid attributes" do
    task = Task.new(title: "Test Task", status: "todo")
    assert task.save, "有効な属性でタスクが保存できませんでした"
  end

  test "should set default status to todo" do
    task = Task.new(title: "Test Task")
    assert_equal "todo", task.status, "デフォルトステータスが'todo'に設定されていません"
  end

  # test "the truth" do
  #   assert true
  # end
end
