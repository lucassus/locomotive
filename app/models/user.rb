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

  # Returns a collection of admin users
  # @return [Array<User>]
  scope :admin, where(:admin => true)

  # Returns a collection of suspended users
  # @return [Array<User>]
  scope :suspended, where(:suspended => true)

  has_many :accounts, :class_name => 'UserAccount'

  # Finds a first user on given conditions.
  # @see http://rubydoc.info/github/plataformatec/devise/master/Devise/Models/Authenticatable/ClassMethods:find_for_authentication
  def self.find_for_authentication(conditions = {})
    conditions[:suspended] = false
    super
  end

  # Check if the user is connected to facebook account
  def connected_to_facebook?
    connected_to?(UserAccount::FACEBOOK)
  end

  # Check if the user is connected to twitter account
  def connected_to_twitter?
    connected_to?(UserAccount::TWITTER)
  end

  # Check if the user is connected to the given account
  def connected_to?(provider)
    accounts.exists?(:provider => provider.to_s)
  end

  def connect_to(provider, options)
    raise if connected_to?(provider)

    attributes = options.merge(:provider =>  provider.to_s)
    accounts.create!(attributes)
  end
end
