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
end

# As a user, I want to mark a task as done, so that I can track my progress