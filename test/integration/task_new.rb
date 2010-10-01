require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  user.lists << List.new(:name => "list foo")
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "list foo"
  click_link "Want to create one?"
end

# As a user, I want to add a task to my list, so that it can reflect what I need to do

test "A user tries to create a task" do
  fill_in "Enter a description for this task", :with => "task foo"
  click_button "Add task"

  assert has_content? "Your task was added"
  assert has_content? "task foo"
end

test "A user submits a blank description" do
  fill_in "Enter a description for this task", :with => ""
  click_button "Add task"

  assert has_content? "1 error prohibited this task from being added:"
  assert has_content? "Description can't be blank"
end