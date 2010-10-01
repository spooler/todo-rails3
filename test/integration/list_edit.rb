require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  Task.destroy_all
  List.destroy_all
  User.destroy_all

  @user = User.create :email => "foo@example.com", :password => "foo"
  @list = @user.lists.create :name => "list foo"
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "edit_#{@list.id}"
end

# As a user, I want to edit a list, so that I can correct the name

test "A user tries to edit a list" do
  fill_in "Type a new name for this list", :with => "list bar"
  click_button "Update list"

  assert has_content? "Your list was updated"
  assert has_content? "list bar"
end

test "A user submits a blank name" do
  fill_in "Type a new name for this list", :with => ""
  click_button "Update list"

  assert has_content? "1 error prohibited this list from being saved:"
  assert has_content? "Name can't be blank"
end

test "A user submits a name already taken" do
  @user.lists << List.new(:name => "list bar")

  fill_in "Type a new name for this list", :with => "list bar"
  click_button "Update list"

  assert has_content? "1 error prohibited this list from being saved:"
  assert has_content? "Name has already been taken"
end