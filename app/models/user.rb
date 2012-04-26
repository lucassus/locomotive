class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  scope :admin, where(:admin => true)

  has_many :encounters, :dependent => :destroy
  has_many :willing_to_meet_users, :as => :users, :through => :encounters, :source => :other_user
end
