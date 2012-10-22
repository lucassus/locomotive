require 'resque/status_server'
require 'resque/job_with_status'

require 'resque_scheduler'
require 'resque_scheduler/server'

# Load jobs
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

# Configuration
Resque.redis = 'localhost:6379'

one_day_in_seconds = 24 * 60 * 60
Resque::Plugins::Status::Hash.expire_in = one_day_in_seconds

# The schedule doesn't need to be stored in a YAML, it just needs to
# be a hash.  YAML is usually the easiest.
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))

module Resque
  class JobWithStatus
    # Wrapper API to forward a Resque::Job creation API call into
    # a JobWithStatus call.
    def self.scheduled(queue, klass, *args)
      create(*args)
    end
  end
end
