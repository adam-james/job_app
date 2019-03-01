class ChoresController < ApplicationController
  def index
  end

  def create
    ChoreJob.perform_later
    redirect_to action: :index
  end
end
