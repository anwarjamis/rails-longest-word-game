require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    (0...10).map do
      @letters << ('a'..'z').to_a.shuffle[1]
    end
  end

  def score
    @attempt = params[:attempt]
    grid = params[:grid]
    # Checking if the word is valid in english
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    serialized_dict = URI.open(url).read
    api = JSON.parse(serialized_dict)

    # Returning the values to the score page
    if api["found"] == false
      @message = "not an english word"
    elsif @attempt.upcase!.chars.all? { |char| @attempt.count(char) <= grid.count(char) }
      @message = "well done"
    else
      @message = "not in the grid"
    end
  end
end
