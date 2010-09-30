class Task < ActiveRecord::Base
  belongs_to :list

  # validates :description, :presence => true
  validates_presence_of :description
end
