require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @attempt = params[:attempt]
    grid = params[:letters]
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
