class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published

  ## Scopes
  scope :published, where(:published => true)
  scope :unpublished, where(:published => false)
  scope :recent, lambda { |n| published.order('created_at DESC').limit(n) }

  ## Validations
  validates :title, :presence => true

  # Generates nice post id, for example `123-the-post-title`
  # @return [String] Nice post id
  def to_param
    sanitized_title = self.title.downcase.gsub(/\?!/, '').gsub(/[^a-z0-9]+/i, '-')
    "#{self.id}-#{sanitized_title}"
  end
end
