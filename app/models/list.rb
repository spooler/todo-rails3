class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  accepts_nested_attributes_for :tasks

  # validates :name, :presence => true, :uniquenes => { :scope => :user_id }
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id
end