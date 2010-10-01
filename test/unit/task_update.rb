require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  @list = user.lists.create :name => "list foo"
  @task = @list.tasks.create :description => "task foo"
end

test "should be valid with a new description" do
  @task.description = "task bar"
  assert @task.valid?
end

test "should not be valid with a blank new description" do
  @task.description = ""
  assert !@task.valid?
end