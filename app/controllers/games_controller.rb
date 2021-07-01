require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @a = ('A'..'Z').to_a
    @letters = 10.times.map { @a.sample }
  end

  def included?(letters, word)
    word.upcase.chars.all? do |letter|
      word.upcase.count(letter) <= letters.count(letter)
    end
  end

  def in_dict
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @answer = URI.open(@url).read
    @search = JSON.parse(@answer)
    return @search["found"]
  end

  def reset
    session[:score] = 0
    redirect_to :new
  end

  def score
    session[:score] = 0 if session[:score].nil?
    @count = if !included?(params[:letters], params[:word])
      @message = "Sorry, #{params[:word]} is out of the grid"
      session[:score]
    elsif in_dict
      @message = "Well done! #{params[:word]} is a valid English word"
      session[:score] = session[:score].to_i + 1
    else
      @message = "Sorry, #{params[:word]} is not an English word"
      session[:score]
    end
  end

end
