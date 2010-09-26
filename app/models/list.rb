class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :delete_all

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id
end
