require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'

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

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'capybara/email/rspec'
  require 'vcr'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  I18n.default_locale = I18n.locale = :en

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
end

Spork.each_run do
  # This code will be run each time you run your specs.

  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
  Locomotive::Application.reload_routes!
  FactoryGirl.reload

  # Workarounds for ActiveAdmin
  # see: https://github.com/gregbell/active_admin/issues/918#issuecomment-3741826

  ActionView::Template.register_template_handler :arb, lambda { |template|
    "self.class.send :include, Arbre::Builder; @_helpers = self; self.extend ActiveAdmin::ViewHelpers; self.extend ApplicationHelper; @__current_dom_element__ = Arbre::Context.new(assigns, self); begin; #{template.source}; end; current_dom_context"
  }

  ActiveAdmin.unload!
  ActiveAdmin.load!
end if Spork.using_spork?
