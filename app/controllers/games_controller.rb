class GamesController < ApplicationController
  def new
    @letters = []
    (0...10).map do
      @letters << ('a'..'z').to_a.shuffle[1]
    end
  end

  def score
    @attempt = params[:attempt]
    # Lógica
    @score
  end
end
