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

# As a user, I want to create a list, so that I can group my pending tasks

test "A user tries to create a list" do
  click_link "Want to create one?"
  fill_in "Enter a name for this list", :with => "list foo"
  click_button "Create list"

  assert has_content? 'Your list "list foo" was created'
  assert has_content? "You have not created any tasks yet."
  assert has_xpath?("//a", text: "Want to create one?")
end

test "A user submits a blank name" do
  click_link "Want to create one?"
  fill_in "Enter a name for this list", :with => ""
  click_button "Create list"

  assert has_content? "1 error prohibited this list from being created:"
  assert has_content? "Name can't be blank"
end

test "A user submits a name already taken" do
  @user.lists << List.new(:name => "list foo")

  click_link "New list"
  fill_in "Enter a name for this list", :with => "list foo"
  click_button "Create list"

  assert has_content? "1 error prohibited this list from being created:"
  assert has_content? "Name has already been taken"
end