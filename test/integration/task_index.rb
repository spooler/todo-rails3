require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  @list = user.lists.create :name => "list foo"
end

setup do
  sign_in "foo@example.com", "foo"
end

# As a user, I want to view all the tasks of one of my lists, so that I can review my pending

test "A user tries to view the tasks of a list" do
  task_foo = @list.tasks.create :description => "task foo"
  task_bar = @list.tasks.create :description => "task bar"

  click_link "list foo"

  assert has_content? "list foo"
  assert has_content? "task foo"
  assert has_content? "task bar"
  assert has_css? "a#edit_#{task_foo.id}"
  assert has_css? "a#edit_#{task_bar.id}"
  assert has_css? "a#delete_#{task_foo.id}"
  assert has_css? "a#delete_#{task_bar.id}"
end

test "A user tries to view the tasks of a list, but he has no tasks on that list yet" do
  click_link "list foo"

  assert has_content? "You have not created any tasks yet."
  assert has_xpath?("//a", text: "Want to create one?")
end

# As a user, I want to mark a task as complete, so that I can track my progress
test "A user tries to mark a task as complete" do
  task_foo = @list.tasks.create :description => "task foo"
  task_bar = @list.tasks.create :description => "task bar"

  click_link "list foo"
end