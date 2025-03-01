require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should not save task without title" do
    task = Task.new(status: 'todo')
    assert_not task.save, "Saved the task without a title"
  end

  test "should not save task with invalid status" do
    task = Task.new(title: 'Test Task', status: 'invalid_status')
    assert_not task.save, "Saved the task with an invalid status"
  end

  test "should save task with valid attributes" do
    task = Task.new(title: 'Test Task', status: 'todo')
    assert task.save, "Could not save the task with valid attributes"
  end

  test "should set default status to todo" do
    task = Task.new(title: 'Test Task')
    assert_equal 'todo', task.status, "Default status was not set to todo"
  end

  # test "the truth" do
  #   assert true
  # end
end
