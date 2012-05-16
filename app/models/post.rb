class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published

  ## Scopes
  scope :published, where(:published => true)

  ## Validations
  validates :title, :presence => true
end
