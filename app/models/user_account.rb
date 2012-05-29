class UserAccount < ActiveRecord::Base
  attr_accessible :provider, :uid, :token, :auth_response

  FACEBOOK = 'facebook'.freeze
  TWITTER = 'twitter'.freeze
  GOOGLE = 'google'.freeze

  belongs_to :user
end
