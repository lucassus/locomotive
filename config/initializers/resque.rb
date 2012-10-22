require 'resque/status_server'
require 'resque/job_with_status'

# Load jobs
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

# Configuration
Resque.redis = 'localhost:6379'

one_day_in_seconds = 24 * 60 * 60
Resque::Plugins::Status::Hash.expire_in = one_day_in_seconds
