source 'https://rubygems.org'

gem 'rails', '3.2.11'

# PostgreSQL client library
gem 'pg'

# a very fast & simple Ruby web server
gem 'thin'
# authentication solution for Rails with Warden
gem 'devise'
# translations for the devise gem
gem 'devise-i18n'

# flexible authentication system utilizing Rack middleware
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google'

# simple DSL for rendering forms
gem 'simple_form'
# settings solution that uses an ERB enabled YAML file and a singleton design pattern
gem 'settingslogic'
# markdown processor in Ruby
gem 'bluecloth'

# Adds foreign key helpers to migrations and correctly dumps foreign keys to schema.rb
gem 'foreigner'
# Immigrant gives Foreigner a migration generator so you can effortlessly add missing foreign keys.
gem 'immigrant'

# Manage Procfile-based applications
gem 'foreman'

# ActiveAdmin dependencies
# TODO reduce activeadmin load time
gem 'activeadmin'

group :production do
  # sending emails that include information about the current request, session, and environment, and also gives a backtrace of the exception
  gem 'exception_notification', require: false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platform: :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'jquery-rails'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
  gem 'markitup_rails'
end

group :development, :test do
  gem 'debugger', require: false
  gem 'awesome_print', require: false

  gem 'factory_girl_rails'
  gem 'faker'

  # Run tests on multiple cores
  gem 'parallel_tests'

  # Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
  gem 'vcr', require: false
  # Library for stubbing and setting expectations on HTTP requests in Ruby. (required by vcr)
  gem 'webmock', require: false
end

group :development do
  # gives information about your application in the footer
  gem 'rails-footnotes'
  # mutes assets pipeline log messages
  gem 'quiet_assets'
  # generates locale files for almost every known language
  gem 'i18n_generators'

  # Ruby Documentation tool
  gem 'yard', require: false
  # gem for Markdown formatting (required by yardoc for generating docs from *.md files)
  gem 'redcarpet'

  # a command line tool to easily handle events on file system modifications
  gem 'guard'

  # speeds up your Rails testing workflow by preloading your Rails environment
  gem 'spin'
  gem 'guard-spin'

  # a code metric tool to check the quality of rails codes
  gem 'rails_best_practices', require: false
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'fuubar'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner'

  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end
