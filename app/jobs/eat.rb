module Eat
  @queue = :food

  def self.perform(food)
    puts "Ate #{food}!"
  end
end
