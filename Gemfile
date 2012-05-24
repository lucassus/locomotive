source 'https://rubygems.org'

gem 'rails', '3.2.3'

# a very fast & simple Ruby web server
gem 'thin'
# authentication solution for Rails with Warden
gem 'devise'
# translations for the devise gem
gem 'devise-i18n'
# flexible authentication system utilizing Rack middleware
gem 'omniauth'
# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook'
# Twitter OAuth2 Strategy for OmniAuth
gem 'omniauth-twitter'
# simple DSL for rendering forms
gem 'simple_form'
# settings solution that uses an ERB enabled YAML file and a singleton design pattern
gem 'settingslogic'
# markdown processor in Ruby
gem 'bluecloth'
# sending emails that include information about the current request, session, and environment, and also gives a backtrace of the exception
gem 'exception_notification'

# ActiveAdmin dependencies
gem 'activeadmin'
gem 'formtastic', '2.0.0'
gem 'meta_search'

# Carrierwave file uploads
gem 'carrierwave'
gem 'fog'

group :production do
  # PostgreSQL client library
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'jquery-rails'
  gem 'twitter-bootstrap-rails'
  gem 'markitup_rails'
end

group :development, :test do
  gem 'sqlite3'

  gem 'debugger'
  gem 'awesome_print'

  gem 'factory_girl_rails'
  gem 'faker'

  # Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
  gem 'vcr', :require => false
  # Library for stubbing and setting expectations on HTTP requests in Ruby. (required by vcr)
  gem 'webmock', :require => false
end

group :development do
  # helpful stuffs for Heroku
  gem 'heroku_san'
  # gives information about your application in the footer
  gem 'rails-footnotes'
  # mutes assets pipeline log messages
  gem 'quiet_assets'
  # generates locale files for almost every known language
  gem 'i18n_generators'

  # Ruby Documentation tool
  gem 'yard'
  # gem for Markdown formatting (required by yardoc for generating docs from *.md files)
  gem 'redcarpet'

  # a command line tool to easily handle events on file system modifications
  gem 'guard'
  # automatically manage Spork DRb servers
  gem 'guard-spork'
  # automatically run your specs
  gem 'guard-rspec'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'capybara'
  gem 'capybara-email'
  gem 'spork'
  gem 'database_cleaner'

  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
end
