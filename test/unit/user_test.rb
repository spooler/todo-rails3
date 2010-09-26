require File.expand_path('../../test_helper',  __FILE__)

class UserTest < ActiveSupport::TestCase
  test "Create a user" do
    # "be valid with a correct email address" do
    @user = User.new :email => "foo@example.com", :password => "foobar"
    assert @user.valid?

    # "be invalid with an incorrect email address" do
    @user = User.new :email => "fooexample.com", :password => "foobar"
    assert !@user.valid?
  end

  test "Update a user" do
    @user = User.create :email => "foo@example.com", :password => "foobar"

    # "be invalid with an incorrect email address" do
    @user.email = "fooexample.com"
    assert !@user.valid?
  end
end