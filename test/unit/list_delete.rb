require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
  @list = @user.lists.create :name => "list foo"
end

test "should destroy the record" do
  @list.destroy
  assert List.find_by_name("list foo") == nil
end

test "should destroy associated tasks" do
  @list.tasks << Task.new(:description => "task foo")
  @list.tasks << Task.new(:description => "task bar")

  @list.destroy
  assert Task.find_by_description("task foo") == nil
  assert Task.find_by_description("task bar") == nil
end