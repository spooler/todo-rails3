# require File.expand_path('../../stories_helper',  __FILE__)
# 
# Protest.story "As a user I want to view all my lists so I can select the one I need" do
#   scenario "A user tries to view their lists" do
#     login_new_user
#     create_list "list 1"
#     create_list "list 2"
#     create_list "list 3"
# 
#     visit "/lists"
# 
#     assert_contain "list 1"
#     assert_contain "list 2"
#     assert_contain "list 3"
#   end
# end
# 
# Protest.story "As a user I want to create a list so I can group my pending tasks" do
#   scenario "A user tries to create a list" do
#     login_new_user
# 
#     click_link "New list"
#     fill_in "Enter a name for this list", :with => "homework"
#     click_button "Create list"
# 
#     assert_contain "Your list homework was created"
#   end
# 
#   scenario "A user tries to create a list with an existent name" do
#     login_new_user
#     create_list "some list"
#     create_list "some list"
# 
#     assert_contain "Name has already been taken"
#   end
# end
# 
# Protest.story "As a user I want to modify the name of a list so I can correct a misspelling" do
# 
#   scenario "A user tries to modify the name of a list" do
#     login_new_user
#     create_list "homewor"
# 
#     visit "/lists"
#     click_link "edit_#{List.first.id}"
#     fill_in "Change the name for this list", :with => "homework"
#     click_button "Update"
# 
#     assert_contain "homework"
#     assert_contain "Your list was updated"
#   end
# end
# 
# Protest.story "As a user I want to delete a list so I can remove what I no longer use" do
#   scenario "A user tries to delete a list" do
#     login_new_user
#     create_list "homework"
# 
#     visit "/lists"
#     click_link "delete_#{List.first.id}"
# 
#     assert_contain "Your list homework was deleted"
#   end
# end