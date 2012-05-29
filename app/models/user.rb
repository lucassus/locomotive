# User model
#
# Important fields:
# * email <String>
# * admin <Boolean> if it's set to true, it means that an user can access to the admin panel
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :suspended

  has_many :accounts, :class_name => 'UserAccount'
  include User::Accounts

  # Returns a collection of admin users
  # @return [Array<User>]
  scope :admin, where(:admin => true)

  # Returns a collection of suspended users
  # @return [Array<User>]
  scope :suspended, where(:suspended => true)

  # Finds a first user on given conditions.
  # @see http://rubydoc.info/github/plataformatec/devise/master/Devise/Models/Authenticatable/ClassMethods:find_for_authentication
  def self.find_for_authentication(conditions = {})
    conditions[:suspended] = false
    super
  end
end
