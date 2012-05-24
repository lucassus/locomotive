if Rails.env.development? and ENV['VCR_LOGGING'].present?
  puts "#{'-' * 16} Initializing VCR for logging all HTTP requests"

  # Configure VCR to log all HTTP requests
  # In this configuration VCR will never replay previously recorded interactions
  # In order to enable VCR logging run the server with the following command: VCR_LOGGING=1 rails server
  # See also /config/environments/development.rb
  require 'vcr'

  VCR.configure do |c|
    c.cassette_library_dir = File.expand_path('log', Rails.root)
    c.hook_into :webmock
  end
end
