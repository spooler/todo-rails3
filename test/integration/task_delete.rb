require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  list = user.lists.create :name => "list foo"
  @task = list.tasks.create :description => "task foo"
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "list foo"
end

# As a user, I want to delete a task, so that I can remove what I no longer use

with(:selenium) do
  test "A user tries to delete a task" do
    page.evaluate_script('window.confirm = function() { return true; };')
    click_link "delete_#{@task.id}"

    assert has_content? 'The task was deleted'
    assert Task.find_by_description("task foo") == nil
  end
end