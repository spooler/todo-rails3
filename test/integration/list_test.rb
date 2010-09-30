require File.expand_path('../../integration_test_helper',  __FILE__)

class ListTest < ActionController::IntegrationTest
  setup do
    @user = User.create :email => "foo@example.com", :password => "foo"
    sign_in "foo@example.com", "foo"
  end

  teardown do
    click_link "Sign out"
  end

  # index
  context "As a user, I want to view all my lists, so that I can select the one I need" do
    test "A user tries to view their lists" do
      list_foo = @user.lists.create :name => "list foo"
      list_bar = @user.lists.create :name => "list bar"

      visit "/lists"

      assert page.has_content? "list foo"
      assert page.has_content? "list bar"
      page.has_css? "edit_#{list_foo.id}"
      page.has_css? "edit_#{list_bar.id}"
      page.has_css? "delete_#{list_foo.id}"
      page.has_css? "delete_#{list_bar.id}"
    end

    test "A user tries to view their lists, but he has no lists yet" do
      assert page.has_content? "You have not created any lists yet."
      page.has_css? "a", :content => "Want to create one?"
    end
  end

  # new / create
  context "As a user, I want to create a list, so that I can group my pending tasks" do
    test "A user tries to create a list" do
      click_link "Want to create one?"
      fill_in "Enter a name for this list", :with => "list foo"
      click_button "Create list"

      assert page.has_content? 'Your list "list foo" was created'
      assert page.has_content? "You have not created any tasks yet."
      page.has_css? "a", :content => "Want to create one?"
    end

    test "A user submits a blank name" do
      click_link "Want to create one?"
      fill_in "Enter a name for this list", :with => ""
      click_button "Create list"

      assert page.has_content? "1 error prohibited this list from being created:"
      assert page.has_content? "Name can't be blank"
    end

    test "A user submits a name already taken" do
      @user.lists << List.new(:name => "list foo")

      click_link "New list"
      fill_in "Enter a name for this list", :with => "list foo"
      click_button "Create list"

      assert page.has_content? "1 error prohibited this list from being created:"
      assert page.has_content? "Name has already been taken"
    end
  end

  # edit / update
  context "As a user I want to edit a list, so that I can correct the name" do
    setup do
      @list = @user.lists.create :name => "list foo"
      visit "/lists"
      click_link "edit_#{@list.id}"
    end

    test "A user tries to edit a list" do
      fill_in "Type a new name for this list", :with => "list bar"
      click_button "Update list"

      assert page.has_content? "Your list was updated"
      assert page.has_content? "list bar"
    end

    test "A user submits a blank name" do
      fill_in "Type a new name for this list", :with => ""
      click_button "Update list"

      assert page.has_content? "1 error prohibited this list from being saved:"
      assert page.has_content? "Name can't be blank"
    end

    test "A user submits a name already taken" do
      @user.lists << List.new(:name => "list bar")

      fill_in "Type a new name for this list", :with => "list bar"
      click_button "Update list"

      assert page.has_content? "1 error prohibited this list from being saved:"
      assert page.has_content? "Name has already been taken"
    end
  end

  # delete 
  context "As a user, I want to delete a list, so that I can remove what I no longer use" do
    test "A user tries to delete a list" do
      list = @user.lists.create :name => "list foo"

      visit "/lists"
      click_link "delete_#{list.id}"

      assert page.has_content? 'Your list "list foo" was deleted'
      assert_equal nil, List.find_by_name("list foo") 
    end
  end
end