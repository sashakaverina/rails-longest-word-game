require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @a = ('A'..'Z').to_a
    @letters = 10.times.map { @a.sample }
  end

  def score
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @answer = URI.open(@url).read
    @search = JSON.parse(@answer)
    if !@search["found"]
      @message = "Sorry, your word is not an english word"
    else
      @message = "Well done"
    end
  end

end
