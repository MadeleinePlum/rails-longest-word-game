require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters.join
  end

  def score
    english_word = english_word(params[:word])
    if included?(params[:word], params[:letters])
      if english_word
        @answer = "Congratulations! #{params[:word]} is a valid english word!"
      elsif !english_word
        @answer = " #{params[:word]} is not an valid english word"
      end
    else
      @answer = "#{params[:word]} cannot be built out of #{params[:letters]}"
    end
  end

  def included?(guess, letters)
    guess.upcase.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  def english_word(word)
    url = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end
end
