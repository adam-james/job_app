class ChoresController < ApplicationController
  def index
    @chores = Chore.all
  end

  def create
    ChoreJob.perform_later
    redirect_to action: :index
  end
end
