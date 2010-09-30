require File.expand_path('../../test_helper',  __FILE__)

class TaskTest < ActiveSupport::TestCase
  setup do
    Task.destroy_all
    List.destroy_all
    User.destroy_all

    user = User.create :email => "foo@example.com", :password => "foo"
    @list = user.lists.create :name => "list foo"
  end

  context "Creating a task" do
    test "should be valid with an associated list and a description" do
      task = Task.new :list => @list, :description => "task foo"
      assert task.valid?
    end

    test "should not be valid with a blank description" do
      task = @list.tasks.new :description => ""
      assert !task.valid?
    end
  end

  context "Updating a task" do
    setup do
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
  end

  context "Deleting a task" do
    setup do
      @task = @list.tasks.create :description => "task foo"
    end

    test "should destroy the record" do
      @task.destroy
      assert_nil Task.find_by_description("task foo")
    end
  end
end