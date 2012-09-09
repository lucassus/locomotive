require 'rubygems'
require 'bundler/setup'

root_path = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path)

# Load database config
require 'erb'

env = ENV['RAILS_ENV'] || 'test'
yml = ERB.new(IO.read(File.join(root_path, 'config', 'database.yml'))).result
database_config = YAML::load(yml)[env]

# Establish connection with database
require 'active_record'
ActiveRecord::Base.establish_connection(database_config)

Dir[File.join(root_path, "app/models/extensions**/*.rb")].each { |f| require f }
Dir[File.join(root_path, "app/models/**/*.rb")].each { |f| require f }

# Load support.factories
require 'factory_girl'
Dir[File.join(root_path, "spec/support/factories/**/*.rb")].each { |f| require f }

require 'rspec'
require 'shoulda-matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(root_path, "spec/support/**/*.rb")].each {|f| require f}

require 'database_cleaner'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

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
end
