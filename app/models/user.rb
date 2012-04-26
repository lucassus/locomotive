class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Scopes
  scope :admin, where(:admin => true)

  ## Associations
  has_many :encounters, :dependent => :destroy
  has_many :willing_to_meet_users, :as => :users, :through => :encounters, :source => :other_user
  has_many :want_to_meet_users, :as => :users, :through => :encounters, :source => :other_user,
           :conditions => ['interest_type = ?', :meet_yes]

  has_many :encounters_reverse, :foreign_key => :other_user_id, :class_name => 'Encounter', :dependent => :destroy
  has_many :willing_to_meet_me_users, :as => :users, :through => :encounters_reverse, :source => :user
  has_many :want_to_meet_me_users, :as => :users, :through => :encounters_reverse, :source => :user,
           :conditions => ['interest_type = ?', :meet_yes]

  def want_to_meet_me?(other)
    self.want_to_meet_me_users.exists?(:id => other.id)
  end

  # TODO
  # maybe_want_to_meet_me?
  # do_not_want_to_meet_me?
end
