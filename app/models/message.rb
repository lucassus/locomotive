# Tabless model for handling contact us form
class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :body

  validates :name, :email, :body, presence: true
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
