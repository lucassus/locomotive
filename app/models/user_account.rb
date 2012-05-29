class UserAccount < ActiveRecord::Base
  attr_accessible :provider, :uid, :token, :auth_response

  belongs_to :user
end
