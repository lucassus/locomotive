class Eat
  include Resque::Plugins::Status
  @queue = :food

  def perform
    puts "Ate #{options['food']}!"
  end
end
