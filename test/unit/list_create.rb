require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
end

test "should be valid with an associated user and a name" do
  list = List.new :user => @user, :name => "list foo"
  assert list.valid?
end

test "should be able to have tasks" do
  list = @user.lists.create :name => "list foo"
  list.tasks << Task.new(:description => "task foo")
  list.tasks << Task.new(:description => "task bar")
  assert list.tasks.count == 2
end

test "should not be valid with a blank name" do
  list = @user.lists.new :name => ""
  assert !list.valid?
end

test "should not be valid with a name already taken" do
  @user.lists << List.new(:name => "list foo")
  list = @user.lists.new :name => "list foo"
  assert !list.valid?
end