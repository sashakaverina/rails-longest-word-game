require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @a = ('A'..'Z').to_a
    @letters = 10.times.map { @a.sample }
    @count = 0
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

  def score
    if !included?(params[:letters], params[:word])
      @message = "Sorry, #{params[:word]} is out of the grid"
    elsif in_dict
      @message = "Well done! #{params[:word]} is a valid English word"
      @count = params[:word].length
    else
      @message = "Sorry, #{params[:word]} is not an English word"
    end
  end

  private

  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

end
