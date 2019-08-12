require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    input = params[:word_input]
    array = params[:letters].split
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    serialized_wagon_dic = open(url).read
    word = JSON.parse(serialized_wagon_dic)
    falsy = input.upcase.split('').map { |char| array.include?(char) ? array.delete_at(array.index(char)) : 'false' }
    if word['found'] == false
      @response = "Sorry, but #{input.upcase} does not seems to be a valid English word"
    elsif falsy.include? 'false'
      @response = "Sorry, but #{input.upcase} can't be built out of #{array}"
    else
      @response = "Congratulations! #{input.upcase} is a valid English word"
    end
  end
end
