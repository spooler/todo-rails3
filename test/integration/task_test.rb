# require File.expand_path('../../stories_helper',  __FILE__)
# 
# Protest.story "As a user I want to create a task so I reflect what I need to do" do
#   scenario "A user tries to create a task" do
#     login_new_user
#     create_list "homework"
# 
#     click_link "New task"
#     fill_in "Enter a description for this task", :with => "create a todo app"
#     click_button "Add task"
# 
#     assert_contain "create a todo app"
#     assert_contain "Your task was added"
#   end
# end
# 
# Protest.story "As a user I want to view all the tasks of one of my lists so I can review my pending" do
#   scenario "A user checks his list of tasks" do
#     login_new_user
#     create_list "homework"
#     create_task "Foo"
#     create_task "Bar"
# 
#     assert_contain "Foo"
#     assert_contain "Bar"
#   end
# end
# 
# Protest.story "As a user I want to edit a task I fix my typing errors" do
#   scenario "A user edits a task" do
#     login_new_user
#     create_list "homework"
#     create_task "Foo"
# 
#     click_link "edit_#{Task.first.id}"
#     fill_in "Type a new description for this task", :with => "Bar"
#     click_button "Update task"
# 
#     assert_contain "The task was updated"
#     assert_contain "Bar"
#   end
# end
# 
# Protest.story "As a user I want to remove a task so I can get rid of stuff I no longer need" do
#   scenario "A user removes a task" do
#     login_new_user
#     create_list "homework"
#     create_task "Foo"
# 
#     click_link "delete_#{Task.first.id}"
# 
#     assert_contain "The task was deleted"
#   end
# end
# 
# Protest.story "As a user I want to change the state of a task so I can track my progress"