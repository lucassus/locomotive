require 'rubygems'

# Setup simplecov
# In order to run test code coverage execute the following command `SIMPLECOV=1 rspec spec`
# (it has to be defined before RSpec.configure block)
if ENV['SIMPLECOV'] and not Spork.using_spork?
  require 'simplecov'
  require 'simplecov-rcov'

  SimpleCov.start 'rails'
  class SimpleCov::Formatter::MergedFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      SimpleCov::Formatter::RcovFormatter.new.format(result)
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
  SimpleCov.coverage_dir('reports/coverage')
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'capybara/email/rspec'
require 'vcr'

require 'debugger'
require 'awesome_print'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('spec/vcr_cassettes', Rails.root)
  c.hook_into :webmock
end

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  config.include FactoryGirl::Syntax::Methods
  config.include Macros::UserLogin, :type => :request
  config.include Macros::Mailer, :type => :request

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Tell a controller example group to not reader views
  config.render_views = false
end
