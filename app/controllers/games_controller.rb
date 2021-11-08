require 'open-uri'
# require 'json'
# require 'date'

class GamesController < ApplicationController


  def new
    @grid = 10.times.map{ ('A'..'Z').to_a.sample }
  end


   def score
    @grid = params[:grid].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @grid)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
