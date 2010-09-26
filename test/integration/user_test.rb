require File.expand_path('../../integration_test_helper',  __FILE__)

# class UserTest < ActionController::IntegrationTest
#   test "A user tries to create an account" do
#     visit "/"
#     click_link "Sign up"
#     fill_in "Your email",                :with => "test@test.com"
#     fill_in "Create a password",         :with => "test"
#     fill_in "Confirm your new password", :with => "test"
#     click_button "Sign up"
# 
#     assert page.has_content? "You have signed up successfully"
#     assert page.has_content? "Signed in as test@test.com"
#     assert page.has_content? "Sign out"
#     assert page.has_no_content? "Sign up"
#     assert page.has_no_content? "Sign in"
#   end
# end

class UserTest < ActionController::IntegrationTest
  test "A user tries to sign in" do
    User.create(:email => "test@test.com", :password => "test", :password_confirmation => "test", :remember_me => false)

    visit "/"
    click_link "Sign in"
    fill_in "Your email",    :with => "test@test.com"
    fill_in "Your password", :with => "test"
    click_button "Sign in"

    assert page.has_content? "You have signed up successfully"
    assert page.has_content? "Signed in as test@test.com"
    assert page.has_content? "Sign out"
    assert page.has_no_content? "Sign up"
    assert page.has_no_content? "Sign in"
  end
end

# Protest.story "As a user I want to create an account so I can use the web app" do
#   scenario "A user tries to create an account" do
#     visit "/"
#     click_link "Sign up"
#     fill_in "Your email", :with => "test@test.com"
#     fill_in "Create a password", :with => "test"
#     click_button "Sign Up"
# 
#     assert_contain "Welcome test@test.com"
#     assert_contain "Logout"
#     assert_not_contain "Sign Up"
#     assert_not_contain "Login"
#   end
# 
#   scenario "A user submit an existent email" do
#     user = User.create :email => "test@test.com", :password => "test"
# 
#     visit "/"
#     click_link "Sign Up"
#     fill_in "Your email", :with => user.email
#     fill_in "Create a password", :with => "test"
#     click_button "Sign Up"
# 
#     assert_contain "Email has already been taken"
#     assert_not_contain "Welcome #{user.email}"
#     assert_not_contain "Logout"
#   end
# 
#   scenario "A user submit a blank email" do
#     visit "/"
#     click_link "Sign Up"
#     fill_in "Your email", :with => ""
#     fill_in "Create a password", :with => "test"
#     click_button "Sign Up"
# 
#     assert_contain "Email can't be blank"
#     assert_not_contain "Welcome "
#     assert_not_contain "Logout"
#   end
# end
# 
# Protest.story "As a user I want to login so I can access restricted features" do
#   scenario "A user tries to login" do
#     login_new_user
# 
#     assert_contain "Welcome #{@user.email}"
#     assert_contain "Logout"
#     assert_not_contain "Sign Up"
#     assert_not_contain "Login"
#   end
# end
# 
# Protest.story "As a user I want to log out so I can prevent others from using my account" do
#   scenario "A user tries to logout" do
#     login_new_user
#     click_link "Logout"
# 
#     assert_contain "Sign Up"
#     assert_contain "Login"
#     assert_not_contain "Welcome #{@user.email}"
#     assert_not_contain "Logout"
#   end
# end
# 
# Protest.story "As a user I want to edit my account so I can change my email and password" do
#   scenario "A user tries to edit his account" do
#     login_new_user
#     click_link "My account"
#     fill_in "Your email", :with => "test@testing.com"
#     fill_in "Your password", :with => "testing"
#     click_button "Update"
# 
#     assert_contain "Your account was updated"
#     assert_equal "test@testing.com", User.find(@user.id).email
#     assert_equal "testing", User.find(@user.id).password
#   end
# end
# 
# Protest.story "As a user I want to delete my account so I remove my information from the website" do
#   scenario "A user tries to delete his account" do
#     login_new_user
#     click_link "My account"
#     click_link "permanently delete my account"
# 
#     assert_contain "Your account was deleted"
#     assert_equal nil, User.find_by_email("test@test.com") 
#   end
# end
