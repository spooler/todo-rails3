require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  User.destroy_all
  User.create :email => "foo@example.com", :password => "foo"
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "My account"
end

# As a user, I want to edit my account, so that I can change my email address and password

test "A user tries to edit his account" do
  fill_in "Change your email", :with => "bar@example.com"
  fill_in "New password", :with => "bar"
  fill_in "Confirm your new password", :with => "bar"
  fill_in "Your current password", :with => "foo"
  click_button "Update"

  assert has_content? "You updated your account successfully"
  assert has_content? "Signed in as bar@example.com"

  click_link "Sign out"

  sign_in "bar@example.com", "bar"

  assert has_content? "Signed in successfully"
  assert has_content? "Signed in as bar@example.com"
end

test "A user submits a blank email address, a blank password and a confirmation password that doesn't match password" do
  fill_in "Change your email", :with => ""
  fill_in "New password", :with => ""
  fill_in "Confirm your new password", :with => "bar"
  fill_in "Your current password", :with => "foo"
  click_button "Update"

  assert has_content? "3 errors prohibited this user from being saved:"
  assert has_content? "Email can't be blank"
  assert has_content? "Password can't be blank"
  assert has_content? "Password doesn't match confirmation"
end

test "A user submits a non valid email address" do
  fill_in "Change your email", :with => "barexample.com"
  fill_in "New password", :with => "bar"
  fill_in "Confirm your new password", :with => "bar"
  fill_in "Your current password", :with => "foo"
  click_button "Update"

  assert has_content? "1 error prohibited this user from being saved:"
  assert has_content? "Email is invalid"
end

test "A user submits an email address already taken" do
  User.create(:email => "bar@example.com", :password => "bar")

  fill_in "Change your email", :with => "bar@example.com"
  fill_in "New password", :with => "bar"
  fill_in "Confirm your new password", :with => "bar"
  fill_in "Your current password", :with => "foo"
  click_button "Update"

  assert has_content? "1 error prohibited this user from being saved:"
  assert has_content? "Email has already been taken"
end