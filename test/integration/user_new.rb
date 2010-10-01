require File.expand_path('../../integration_test_helper',  __FILE__)

# As a visitor, I want to create an account, so that I can use the app

prepare do
  User.destroy_all
end

setup do
  visit "/users/sign_up"
end

test "A visitor tries to create an account" do
  fill_in "Your email",            :with => "foo@example.com"
  fill_in "Create a password",     :with => "foo"
  fill_in "Confirm your password", :with => "foo"
  click_button "Sign up"

  assert has_content? "You have signed up successfully"
  assert has_content? "Signed in as foo@example.com"
end

test "A visitor submits a blank email address, a blank password and a confirmation password that doesn't match password" do
  fill_in "Your email",            :with => ""
  fill_in "Create a password",     :with => ""
  fill_in "Confirm your password", :with => "foo"
  click_button "Sign up"

  assert has_content? "3 errors prohibited this user from being saved:"
  assert has_content? "Email can't be blank"
  assert has_content? "Password can't be blank"
  assert has_content? "Password doesn't match confirmation"
end

test "A visitor submits a non valid email address" do
  fill_in "Your email",            :with => "fooexample.com"
  fill_in "Create a password",     :with => "foo"
  fill_in "Confirm your password", :with => "foo"
  click_button "Sign up"

  assert has_content? "1 error prohibited this user from being saved:"
  assert has_content? "Email is invalid"
end

test "A visitor submits an email address already taken" do
  User.create(:email => "foo@example.com", :password => "foo")

  fill_in "Your email",            :with => "foo@example.com"
  fill_in "Create a password",     :with => "foo"
  fill_in "Confirm your password", :with => "foo"
  click_button "Sign up"

  assert has_content? "1 error prohibited this user from being saved:"
  assert has_content? "Email has already been taken"
end