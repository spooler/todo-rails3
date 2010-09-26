require File.expand_path('../../test_helper',  __FILE__)

class ListTest < ActiveSupport::TestCase
  # setup do
  #   User.delete_all
  #   List.delete_all
  #   Task.delete_all
  # end
  # 
  # context "A list with tasks" do
  #   setup do
  #     @user = User.create :email => "foo@example.com", :password => "foobar"
  #     @list = @user.lists.create :name => "My first list"
  #     @list.tasks << Task.new(:description => "Foo")
  #     @list.tasks << Task.new(:description => "Bar")
  #   end
  # 
  #   should "delete the associated tasks when destroyed" do
  #     @list.destroy
  # 
  #     assert_nil @user.lists.find_by_name("My first list")
  #     assert_nil Task.find_by_description("Foo")
  #     assert_nil Task.find_by_description("Bar")
  #   end
  # end
end
