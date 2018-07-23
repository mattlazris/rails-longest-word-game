require "json"
require "open-uri"
class GamesController < ApplicationController
  def new
    @game = params[:games]
    @letters = (0...10).map { ("a".."z").to_a.sample.upcase }
  end

  def score
    @letters = params[:letters].split(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    word_check = open(url).read
    parsed = JSON.parse(word_check)
    contains = params[:attempt].split("").all? { |letter| @letters.delete(letter)}

    if parsed["found"] == false
      @result = 0
      @response = "Sorry this is not an English word"
    elsif params[:attempt].length <= @letters.length && contains == true
      @result = params[:attempt].length
      @response = "Well done"
    else
      @result = 0
      @response = "Sorry #{params[:attempt]} can't be built out of #{@letters}"
    end
  end
end




