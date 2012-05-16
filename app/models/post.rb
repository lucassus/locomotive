class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published

  ## Validations
  validates :title, :presence => true
end
