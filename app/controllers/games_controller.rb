require 'json'
require 'open-uri'


class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample
    end
  end

  def score
    guess = params[:word]
    grid = params[:grid]
    if isIncluded?(guess, grid)
      if isEnglish_word?(guess)
        @score = "Congratulations #{guess} is a valid English word"
      else
        @score = "Sorry but #{guess} does not seem to be an Enflish word. Play again"
      end
    else
      @score = "Sorry but #{guess} cannot be built out #{grid}. Play again"
    end
  end

  private

  def isIncluded?(guess, grid)
    result = guess.chars
    result.all? { |letter| result.count(letter) <= grid.count(letter) }
  end

  def isEnglish_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_serialized = open(url).read
    result = JSON.parse(result_serialized)
    result["found"]
  end
end

