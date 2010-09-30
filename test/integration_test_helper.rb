require File.expand_path('../test_helper',  __FILE__)
require "capybara/rails"

module ActionController
  class IntegrationTest
    include Capybara

    def sign_in email, password
      visit "/users/sign_in"
      fill_in "Your email",    :with => email
      fill_in "Your password", :with => password
      click_button "Sign in"
    end
  end
end