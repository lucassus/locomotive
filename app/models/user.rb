# User model
#
# Important fields:
# * email <String>
# * admin <Boolean> if it's set to true, it means that an user can access to the admin panel
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Returns a collection of admin users
  # @return [Array<User>]
  scope :admin, where(:admin => true)
end
