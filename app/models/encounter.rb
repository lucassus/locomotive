class Encounter < ActiveRecord::Base
  INTEREST_TYPES = [:meet_yes, :meet_maybe, :meet_no]

  belongs_to :user
  belongs_to :other_user, :class_name => 'User'
end
