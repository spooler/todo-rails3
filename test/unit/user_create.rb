require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  List.destroy_all
  User.destroy_all
end

test "should be valid with an email address and a password" do
  user = User.new :email => "foo@example.com", :password => "foo"
  assert user.valid?
end

test "should be able to have lists" do
  user = User.create :email => "foo@example.com", :password => "foo"
  user.lists << List.new(:name => "list foo")
  user.lists << List.new(:name => "list bar")
  assert user.lists.count == 2
end

test "should not be valid with a blank email address" do
  user = User.new :email => "", :password => "foo"
  assert !user.valid?
end

test "should not be valid with a non valid email address" do
  user = User.new :email => "fooexample.com", :password => "foo"
  assert !user.valid?
end

test "should not be valid with an email address already taken" do
  User.create :email => "foo@example.com", :password => "foo"
  user = User.new :email => "foo@example.com", :password => "foo"
  assert !user.valid?
end

test "should not be valid with a blank password" do
  user = User.new :email => "foo@example.com", :password => ""
  assert !user.valid?
end

test "should not be valid with a password too short" do
  user = User.new :email => "foo@example.com", :password => "f"
  assert !user.valid?
end