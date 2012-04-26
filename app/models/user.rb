class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Associations
  has_many :encounters, :dependent => :destroy
  with_options :as => :users, :through => :encounters, :source => :other_user do |user|
    user.has_many :willing_to_meet_users
    user.has_many :want_to_meet_users, :conditions => ['interest_type = ?', :meet_yes]
  end

  has_many :encounters_reverse, :foreign_key => :other_user_id, :class_name => 'Encounter', :dependent => :destroy
  with_options :as => :users, :through => :encounters_reverse, :source => :user do |user|
    user.has_many :willing_to_meet_me_users
    user.has_many :want_to_meet_me_users, :conditions => ['interest_type = ?', :meet_yes]
  end

  ## Scopes
  scope :admin, where(:admin => true)
  scope :mature, where(['age > ?', 18])

  def want_to_meet_me?(other)
    self.want_to_meet_me_users.exists?(:id => other.id)
  end

  def not_encountered_users
    user_table = User.arel_table
    encounters_table = Encounter.arel_table

    User.where(
        user_table[:id].not_in(
            encounters_table.where(
                encounters_table[:user_id].eq(self.id)).project(encounters_table[:other_user_id]))).
        where(user_table[:id].not_eq(self.id))
  end

  # TODO
  # maybe_want_to_meet_me?
  # do_not_want_to_meet_me?
  # etc.
end
