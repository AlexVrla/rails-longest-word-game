require 'open-uri'
# require 'json'
# require 'date'

class GamesController < ApplicationController


  def new
    @grid = 10.times.map{ ('A'..'Z').to_a.sample }
  end


  def score
    @grid = params[:grid].split
    @guess = params[:word].upcase
    @valid_word = valid_word?(@guess)
    @in_grid = in_grid?(@guess, @grid)
  end


private

  def in_grid?(guess, grid)
    guess.upcase.split("").all? do |letter|
      guess.upcase.count(letter) <= grid.count(letter)
    end
  end

  def  valid_word?(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']

  end
end
