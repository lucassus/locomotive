class Encounter < ActiveRecord::Base
  INTEREST_TYPES = [:meet_yes, :meet_maybe, :meet_no]

  scope :meet_yes, where(:interest_type => :meet_yes)
  scope :meet_maybe, where(:interest_type => :meet_maybe)
  scope :meet_no, where(:interest_type => :meet_no)

  belongs_to :user
  belongs_to :other_user, :class_name => 'User'
end
