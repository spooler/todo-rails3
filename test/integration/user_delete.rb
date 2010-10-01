require File.expand_path('../../integration_test_helper',  __FILE__)

prepare do
  User.destroy_all
  User.create :email => "foo@example.com", :password => "foo"
end

setup do
  sign_in "foo@example.com", "foo"
  click_link "My account"
end

# As a user, I want to cancel my account, so that I remove my information from the website

with(:selenium) do
  test "A user tries to cancel his account" do
    page.evaluate_script('window.confirm = function() { return true; };')
    click_link "cancel my account"

    assert has_content? "Sign up"
    assert has_content? "Sign in"
    assert has_no_content? "Signed in as foo@example.com"
    assert has_no_content? "Sign out"
    assert User.find_by_email("foo@example.com") == nil
  end
end