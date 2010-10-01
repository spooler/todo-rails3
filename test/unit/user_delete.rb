require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
end

test "should destroy the record" do
  @user.destroy
  assert User.find_by_email("foo@example.com") == nil
end

test "should destroy associated lists" do
  @user.lists << List.new(:name => "list foo")
  @user.lists << List.new(:name => "list bar")

  @user.destroy
  assert List.find_by_name("list foo") == nil
  assert List.find_by_name("list bar") == nil
end