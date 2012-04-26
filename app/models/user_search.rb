# Simple mode for users search form
class UserSearch
  include ActiveRecord::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :gender_equals
  attr_accessor :age_gte
  attr_accessor :age_lte

  validate :age_min_should_not_be_gte_than_age_max

  ALLOWED_FIELDS = [:gender_equals, :age_gte, :age_lte].freeze

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes)
    ALLOWED_FIELDS.each do |name|
      self.public_send("#{name}=", attributes[name])
    end
  end

  def attributes
    Hash.new.tap do |attributes|
      ALLOWED_FIELDS.each do |field|
        attributes[field] = self.public_send(field)
      end
    end
  end

  # Dummy stub to make validations happy.
  def persisted?
    false
  end

  def new_record?
    true
  end

  private

  def age_min_should_not_be_gte_than_age_max
    if self.age_gte.present? and self.age_lte.present?
      if self.age_gte >= self.age_lte
        errors.add(:age_gte, 'invalid age')
      end
    end
  end
end
