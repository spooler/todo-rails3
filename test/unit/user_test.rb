require File.expand_path('../../test_helper',  __FILE__)

class UserTest < ActiveSupport::TestCase
  setup do
    List.destroy_all
    User.destroy_all
  end

  context "Creating a user" do
    test "should be valid with an email address and a password" do
      user = User.new :email => "foo@example.com", :password => "foo"
      assert user.valid?
    end

    test "should be able to have lists" do
      user = User.create :email => "foo@example.com", :password => "foo"
      user.lists << List.new(:name => "list foo")
      user.lists << List.new(:name => "list bar")
      assert_equal 2, user.lists.count
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
  end

  context "Updating a user" do
    setup do
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
  end

  context "Deleting a user" do
    setup do
      @user = User.create :email => "foo@example.com", :password => "foo"
    end

    test "should destroy the record" do
      @user.destroy
      assert_nil User.find_by_email("foo@example.com")
    end

    test "should destroy associated lists" do
      @user.lists << List.new(:name => "list foo")
      @user.lists << List.new(:name => "list bar")

      @user.destroy
      assert_nil List.find_by_name("list foo")
      assert_nil List.find_by_name("list bar")
    end
  end
end