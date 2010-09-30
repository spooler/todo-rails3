require File.expand_path('../../integration_test_helper',  __FILE__)

class UserTest < ActionController::IntegrationTest
  # new / create
  context "As a visitor, I want to create an account, so that I can use the app" do
    setup do
      visit "/users/sign_up"
    end

    test "A visitor tries to create an account" do
      fill_in "Your email",            :with => "foo@example.com"
      fill_in "Create a password",     :with => "foo"
      fill_in "Confirm your password", :with => "foo"
      click_button "Sign up"

      assert page.has_content? "You have signed up successfully"
      assert page.has_content? "Signed in as foo@example.com"
    end

    test "A visitor submits a blank email address, a blank password and a confirmation password that doesn't match password" do
      fill_in "Your email",            :with => ""
      fill_in "Create a password",     :with => ""
      fill_in "Confirm your password", :with => "foo"
      click_button "Sign up"

      assert page.has_content? "3 errors prohibited this user from being saved:"
      assert page.has_content? "Email can't be blank"
      assert page.has_content? "Password can't be blank"
      assert page.has_content? "Password doesn't match confirmation"
    end

    test "A visitor submits a non valid email address" do
      fill_in "Your email",            :with => "fooexample.com"
      fill_in "Create a password",     :with => "foo"
      fill_in "Confirm your password", :with => "foo"
      click_button "Sign up"

      assert page.has_content? "1 error prohibited this user from being saved:"
      assert page.has_content? "Email is invalid"
    end

    test "A visitor submits an email address already taken" do
      User.create(:email => "foo@example.com", :password => "foo")

      fill_in "Your email",            :with => "foo@example.com"
      fill_in "Create a password",     :with => "foo"
      fill_in "Confirm your password", :with => "foo"
      click_button "Sign up"

      assert page.has_content? "1 error prohibited this user from being saved:"
      assert page.has_content? "Email has already been taken"
    end
  end

  # sign in
  context "As a user, I want to sign in, so that I can access restricted features" do
    setup do
      User.create :email => "foo@example.com", :password => "foo"

      visit "/users/sign_in"
      click_link "Sign in"
    end

    test "A user tries to sign in" do
      fill_in "Your email",    :with => "foo@example.com"
      fill_in "Your password", :with => "foo"
      click_button "Sign in"

      assert page.has_content? "Signed in successfully"
      assert page.has_content? "Signed in as foo@example.com"

      click_link "Sign out"
    end

    test "A user submits a wrong email address" do
      fill_in "Your email",    :with => "bar@example.com"
      fill_in "Your password", :with => "foo"
      click_button "Sign in"

      assert page.has_content? "Invalid email address or password"
    end

    test "A user submits a wrong password" do
      fill_in "Your email",    :with => "foo@example.com"
      fill_in "Your password", :with => "bar"
      click_button "Sign in"

      assert page.has_content? "Invalid email address or password"
    end
  end

  # sign out
  context "As a user, I want to sign out, so that I can prevent others from using my account" do
    test "A user tries to sign out" do
      User.create :email => "foo@example.com", :password => "foo"
      sign_in "foo@example.com", "foo"

      click_link "Sign out"

      assert page.has_content? "Sign up"
      assert page.has_content? "Sign in"
      assert page.has_no_content? "Signed in as foo@example.com"
      assert page.has_no_content? "Sign out"
    end
  end

  # edit / update
  context "As a user, I want to edit my account, so that I can change my email address and password" do
    setup do
      User.create :email => "foo@example.com", :password => "foo"
      sign_in "foo@example.com", "foo"

      click_link "My account"
    end

    teardown do
      click_link "Sign out"
    end

    test "A user tries to edit his account" do
      fill_in "Change your email", :with => "bar@example.com"
      fill_in "New password", :with => "bar"
      fill_in "Confirm your new password", :with => "bar"
      fill_in "Your current password", :with => "foo"
      click_button "Update"

      assert page.has_content? "You updated your account successfully"
      assert page.has_content? "Signed in as bar@example.com"

      click_link "Sign out"

      sign_in "bar@example.com", "bar"

      assert page.has_content? "Signed in successfully"
      assert page.has_content? "Signed in as bar@example.com"
    end

    test "A user submits a blank email address, a blank password and a confirmation password that doesn't match password" do
      fill_in "Change your email", :with => ""
      fill_in "New password", :with => ""
      fill_in "Confirm your new password", :with => "bar"
      fill_in "Your current password", :with => "foo"
      click_button "Update"

      assert page.has_content? "3 errors prohibited this user from being saved:"
      assert page.has_content? "Email can't be blank"
      assert page.has_content? "Password can't be blank"
      assert page.has_content? "Password doesn't match confirmation"
    end

    test "A user submits a non valid email address" do
      fill_in "Change your email", :with => "barexample.com"
      fill_in "New password", :with => "bar"
      fill_in "Confirm your new password", :with => "bar"
      fill_in "Your current password", :with => "foo"
      click_button "Update"

      assert page.has_content? "1 error prohibited this user from being saved:"
      assert page.has_content? "Email is invalid"
    end

    test "A user submits an email address already taken" do
      User.create(:email => "bar@example.com", :password => "bar")

      fill_in "Change your email", :with => "bar@example.com"
      fill_in "New password", :with => "bar"
      fill_in "Confirm your new password", :with => "bar"
      fill_in "Your current password", :with => "foo"
      click_button "Update"

      assert page.has_content? "1 error prohibited this user from being saved:"
      assert page.has_content? "Email has already been taken"
    end
  end

  # delete
  context "As a user, I want to cancel my account, so that I remove my information from the website" do
    setup do
      User.create :email => "foo@example.com", :password => "foo"
      sign_in "foo@example.com", "foo"

      click_link "My account"
    end

    test "A user tries to cancel his account" do
      click_link "cancel my account"

      assert page.has_content? "Sign up"
      assert page.has_content? "Sign in"
      assert page.has_no_content? "Signed in as foo@example.com"
      assert page.has_no_content? "Sign out"
      assert_equal nil, User.find_by_email("foo@example.com") 
    end
  end
end