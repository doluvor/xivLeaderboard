class ScoresController < ApplicationController
  def new
  end

  def index
  	@scores = Score.all
  end

  def create
  	Score.create dps:params[:dps]
  end
end
