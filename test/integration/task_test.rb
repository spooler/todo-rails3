require File.expand_path('../../integration_test_helper',  __FILE__)

class TaskTest < ActionController::IntegrationTest
  setup do
    @user = User.create :email => "foo@example.com", :password => "foo"
    @list = @user.lists.create :name => "list foo"

    sign_in "foo@example.com", "foo"
  end

  teardown do
    click_link "Sign out"
  end

  # index
  context "As a user, I want to view all the tasks of one of my lists, so that I can review my pending" do
    test "A user tries to view the tasks of a list" do
      task_foo = @list.tasks.create :description => "task foo"
      task_bar = @list.tasks.create :description => "task bar"

      click_link "list foo"

      assert page.has_content? "list foo"
      assert page.has_content? "task foo"
      assert page.has_content? "task bar"
      page.has_css? "a#edit_#{task_foo.id}"
      page.has_css? "a#edit_#{task_bar.id}"
      page.has_css? "a#delete_#{task_foo.id}"
      page.has_css? "a#delete_#{task_bar.id}"
    end

    test "A user tries to view the tasks of a list, but he has no tasks on that list yet" do
      click_link "list foo"

      assert page.has_content? "You have not created any tasks yet."
      page.has_css? "a", :content => "Want to create one?"
    end
  end

  # new / create
  context "As a user, I want to add a task to my list, so that it can reflect what I need to do" do
    setup do
      click_link "list foo"
      click_link "Want to create one?"
    end

    test "A user tries to create a task" do
      fill_in "Enter a description for this task", :with => "task foo"
      click_button "Add task"

      assert page.has_content? "Your task was added"
      assert page.has_content? "task foo"
    end

    test "A user submits a blank description" do
      fill_in "Enter a description for this task", :with => ""
      click_button "Add task"
    
      assert page.has_content? "1 error prohibited this task from being added:"
      assert page.has_content? "Description can't be blank"
    end
  end

  # edit / update
  context "As a user I want to edit a task, so that I can correct the description" do
    setup do
      @task = @list.tasks.create :description => "task foo"

      click_link "list foo"
      click_link "edit_#{@task.id}"
    end

    test "A user tries to edit a task" do
      fill_in "Type a new description for this task", :with => "task bar"
      click_button "Update task"

      assert page.has_content? "The task was updated"
      assert page.has_content? "task bar"
    end

    test "A user submits a blank name" do
      fill_in "Type a new description for this task", :with => ""
      click_button "Update task"

      assert page.has_content? "1 error prohibited this task from being saved:"
      assert page.has_content? "Description can't be blank"
    end
  end

  # delete 
  context "As a user, I want to delete a task, so that I can remove what I no longer use" do
    test "A user tries to delete a task" do
      task = @list.tasks.create :description => "task foo"

      click_link "list foo"
      click_link "delete_#{task.id}"

      assert page.has_content? 'The task was deleted'
      assert_equal nil, Task.find_by_description("task foo") 
    end
  end

  # context "As a user, I want to mark a task as done, so that I can track my progress" do
end