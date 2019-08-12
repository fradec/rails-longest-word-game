require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    input = params[:word_input].upcase
    array = params[:letters].split
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    serialized_wagon_dic = open(url).read
    word = JSON.parse(serialized_wagon_dic)
    falsy = input.split('').map { |char| array.include?(char) ? array.delete_at(array.index(char)) : 'false' }
    if word['found'] == false
      @response = "Sorry, <strong>#{input}</strong> doesn't seem to be a valid English word".html_safe
    elsif falsy.include? 'false'
      @response = "Sorry, #{input} can't be built out of #{array}"
    else
      @response = "Congratulations! #{input} is a valid English word"
    end
  end
end
