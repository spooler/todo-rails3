require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  @list = user.lists.create :name => "list foo"
  @task = @list.tasks.create :description => "task foo"
end

test "should destroy the record" do
  @task.destroy
  assert Task.find_by_description("task foo") == nil
end