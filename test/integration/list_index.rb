require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
end

setup do
  sign_in "foo@example.com", "foo"
end

# As a user, I want to view all my lists, so that I can select the one I need

test "A user tries to view their lists" do
  list_foo = @user.lists.create :name => "list foo"
  list_bar = @user.lists.create :name => "list bar"

  visit "/lists"

  assert has_content? "list foo"
  assert has_content? "list bar"

  assert has_css? "a#edit_#{list_foo.id}"
  assert has_css? "a#edit_#{list_bar.id}"
  assert has_css? "a#delete_#{list_foo.id}"
  assert has_css? "a#delete_#{list_bar.id}"
end

test "A user tries to view their lists, but he has no lists yet" do
  assert has_content? "You have not created any lists yet."
  assert has_xpath?("//a", text: "Want to create one?")
end