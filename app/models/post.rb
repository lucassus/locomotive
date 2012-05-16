class Post < ActiveRecord::Base
  ## Validations
  validates :title, :presence => true
end
