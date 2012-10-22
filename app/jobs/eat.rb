class Eat < Resque::JobWithStatus
  @queue = :food

  def perform
    puts "Ate #{options['food']}!"
  end
end
