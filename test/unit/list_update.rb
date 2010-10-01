require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
  @list = @user.lists.create :name => "list foo"
end

test "should be valid with a new name" do
  @list.name = "bar@example.com"
  assert @list.valid?
end

test "should not be valid with a blank new name" do
  @list.name = ""
  assert !@list.valid?
end

test "should not be valid with a new name already taken" do
  @user.lists << List.new(:name => "list bar")

  @list.name = "list bar"
  assert !@list.valid?
end