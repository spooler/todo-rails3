require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  list = user.lists.create :name => "list foo"
  @task = list.tasks.create :description => "task foo"
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "list foo"
  click_link "edit_#{@task.id}"
end

# As a user I want to edit a task, so that I can correct the description

test "A user tries to edit a task" do
  fill_in "Type a new description for this task", :with => "task bar"
  click_button "Update task"

  assert has_content? "The task was updated"
  assert has_content? "task bar"
end

test "A user submits a blank name" do
  fill_in "Type a new description for this task", :with => ""
  click_button "Update task"

  assert has_content? "1 error prohibited this task from being saved:"
  assert has_content? "Description can't be blank"
end