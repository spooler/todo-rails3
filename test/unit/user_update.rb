require File.expand_path('../../cutest_helper',  __FILE__)

prepare do
  List.destroy_all
  User.destroy_all
  @user = User.create :email => "foo@example.com", :password => "foo"
end

test "should be valid with a new email address and a new password" do
  @user.email = "bar@example.com"
  @user.password = "bar"
  assert @user.valid?
end

test "should not be valid with a blank new email address" do
  @user.email = ""
  assert !@user.valid?
end

test "should not be valid with a non valid new email address" do
  @user.email = "fooexample.com"
  assert !@user.valid?
end

test "should not be valid with a new email address already taken" do
  User.create :email => "bar@example.com", :password => "bar"

  @user.email = "bar@example.com"
  assert !@user.valid?
end

test "should not be valid with a blank new password" do
  @user.password = ""
  assert !@user.valid?
end

test "should not be valid with a new password too short" do
  @user.password = "f"
  assert !@user.valid?
end