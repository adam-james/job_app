class ChoresController < ApplicationController
  def index
    @chores = Chore.order(run_at: :desc).limit(10)
  end

  def create
    ChoreJob.perform_later
    redirect_to action: :index
  end
end
