require File.expand_path('../../test_helper',  __FILE__)

class ListTest < ActiveSupport::TestCase
  setup do
    Task.destroy_all
    List.destroy_all
    User.destroy_all

    @user = User.create :email => "foo@example.com", :password => "foo"
  end

  context "Creating a list" do
    test "should be valid with an associated user and a name" do
      list = List.new :user => @user, :name => "list foo"
      assert list.valid?
    end

    test "should be able to have tasks" do
      list = @user.lists.create :name => "list foo"
      list.tasks << Task.new(:description => "task foo")
      list.tasks << Task.new(:description => "task bar")
      assert_equal 2, list.tasks.count
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
  end

  context "Updating a list" do
    setup do
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
  end

  context "Deleting a list" do
    setup do
      @list = @user.lists.create :name => "list foo"
    end

    test "should destroy the record" do
      @list.destroy
      assert_nil List.find_by_name("list foo")
    end

    test "should destroy associated tasks" do
      @list.tasks << Task.new(:description => "task foo")
      @list.tasks << Task.new(:description => "task bar")

      @list.destroy
      assert_nil Task.find_by_description("task foo")
      assert_nil Task.find_by_description("task bar")
    end
  end
end