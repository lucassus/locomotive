# Blog Post model
#
# Important fields:
# * title <String>
# * body <Text>
# * published <Boolean> if it's set to true, it means that the post can be shown to users
class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published

  # Returns a collection of published posts
  # @return [Array<Post>]
  scope :published, where(:published => true)

  # Returns a collection of unpublished posts
  # @return [Array<Post>]
  scope :unpublished, where(:published => false)

  # Returns a collection of recent published posts
  # @param [Integer] n a limit of records to return
  # @return [Array<Post>]
  scope :recent, lambda { |n| published.order('created_at DESC').limit(n) }

  validates :title, :presence => true

  # Generates nice post id, for example "123-the-post-title"
  # @return [String] nice post id
  def to_param
    sanitized_title = self.title.downcase.gsub(/\?!/, '').gsub(/[^a-z0-9]+/i, '-')
    "#{self.id}-#{sanitized_title}"
  end
end
