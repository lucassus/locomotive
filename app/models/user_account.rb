class UserAccount < ActiveRecord::Base
  FACEBOOK = 'facebook'.freeze
  TWITTER = 'twitter'.freeze

  belongs_to :user
end
