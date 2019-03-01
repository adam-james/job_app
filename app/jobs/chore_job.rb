class ChoreJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chore = Chore.new run_at: Time.now
    chore.save!
  end
end
