class ChoreJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "ok, here we go..."
  end
end
