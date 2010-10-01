require File.expand_path('../cutest_helper',  __FILE__)
require "capybara/rails"
include Capybara

def sign_in email, password
  visit "/users/sign_in"
  fill_in "Your email",    :with => email
  fill_in "Your password", :with => password
  click_button "Sign in"
end

def with(driver)
  Capybara.current_driver = driver
  yield
  Capybara.use_default_driver
end