require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  @list = user.lists.create :name => "list foo"
end

test "should be valid with an associated list and a description" do
  task = Task.new :list => @list, :description => "task foo"
  assert task.valid?
end

test "should not be valid with a blank description" do
  task = @list.tasks.new :description => ""
  assert !task.valid?
end