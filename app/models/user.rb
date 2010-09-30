class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :lists, :order => :name, :dependent => :destroy
  accepts_nested_attributes_for :lists
end