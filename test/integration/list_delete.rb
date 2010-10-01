require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  user = User.create :email => "foo@example.com", :password => "foo"
  @list = user.lists.create :name => "list foo"
end

setup do
  sign_in "foo@example.com", "foo"
end

# As a user, I want to delete a list, so that I can remove what I no longer use

with(:selenium) do
  test "A user tries to delete a list" do
    page.evaluate_script('window.confirm = function() { return true; };')
    click_link "delete_#{@list.id}"

    assert has_content? 'Your list "list foo" was deleted'
    assert List.find_by_name("list foo") == nil
  end
end