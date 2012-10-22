class SleepJob
  include Resque::Plugins::Status

  def perform
    total = (options['length'] || 1000).to_i
    num = 0
    while num < total
      at(num, total, "At #{num} of #{total}")
      sleep(1)
      num += 1
    end
  end
end
