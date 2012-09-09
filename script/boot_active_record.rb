require 'rubygems'
require 'bundler/setup'

root_path = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path)

# Load database config
env = ENV['RAILS_ENV'] || 'development'
database_config = YAML::load(File.open(File.join(root_path, 'config', 'database.yml')))[env]

# Establish connection with database
require 'active_record'
ActiveRecord::Base.establish_connection(database_config)

Dir[File.join(root_path, "app/models/extensions**/*.rb")].each { |f| require f }
Dir[File.join(root_path, "app/models/**/*.rb")].each { |f| require f }

# TODO do sth with the db
