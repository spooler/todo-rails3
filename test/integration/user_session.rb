require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  User.destroy_all
  User.create :email => "foo@example.com", :password => "foo"
end

setup do
  visit "/users/sign_in"
end

# As a user, I want to sign in, so that I can access restricted features

test "A user tries to sign in" do
  fill_in "Your email",    :with => "foo@example.com"
  fill_in "Your password", :with => "foo"
  click_button "Sign in"

  assert has_content? "Signed in successfully"
  assert has_content? "Signed in as foo@example.com"
end

test "A user submits a wrong email address" do
  fill_in "Your email",    :with => "bar@example.com"
  fill_in "Your password", :with => "foo"
  click_button "Sign in"

  assert has_content? "Invalid email address or password"
end

test "A user submits a wrong password" do
  fill_in "Your email",    :with => "foo@example.com"
  fill_in "Your password", :with => "bar"
  click_button "Sign in"

  assert has_content? "Invalid email address or password"
end

# As a user, I want to sign out, so that I can prevent others from using my account

test "A user tries to sign out" do
  sign_in "foo@example.com", "foo"
  click_link "Sign out"

  assert has_content? "Sign up"
  assert has_content? "Sign in"
  assert has_no_content? "Signed in as foo@example.com"
  assert has_no_content? "Sign out"
end