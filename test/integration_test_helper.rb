require File.expand_path('../test_helper',  __FILE__)
require "capybara/rails"

module ActionController
  class IntegrationTest
    include Capybara
  end
end

# def login_new_user
#   @user = User.create :email => "test@test.com", :password => "test"
# 
#   visit "/"
#   click_link "Login"
#   fill_in "email", :with => @user.email
#   fill_in "password", :with => @user.password
#   click_button "Login"
# end
# 
# def create_list(name)
#   visit "/lists"
#   click_link "New list"
#   fill_in "Enter a name for this list", :with => name
#   click_button "Create list"
# end
# 
# def create_task(description)
#   click_link "New task"
#   fill_in "Enter a description for this task", :with => description
#   click_button "Add task"
# end
