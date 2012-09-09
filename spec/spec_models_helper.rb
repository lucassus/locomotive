require 'rubygems'
require 'bundler/setup'

root_path = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path)

require_all = lambda do |path|
  Dir[File.join(root_path, "#{path}/**/*.rb")].each do |file|
    require file
  end
end

# Load database config
require 'erb'

env = ENV['RAILS_ENV'] || 'test'
yml = ERB.new(IO.read(File.join(root_path, 'config', 'database.yml'))).result
database_config = YAML::load(yml)[env]

# Establish connection with database
require 'active_record'
ActiveRecord::Base.establish_connection(database_config)

# Load foreigner gem
require 'foreigner'
Foreigner.load

require_all.call 'app/models/extensions'
require_all.call 'app/models'

require 'rspec'
require 'shoulda-matchers'
require 'database_cleaner'
require 'factory_girl'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
require_all.call 'spec/support'

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
