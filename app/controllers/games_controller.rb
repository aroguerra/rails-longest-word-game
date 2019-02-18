require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters_array = []
    @letters_array = Array.new(10) { ('A'..'Z').to_a.sample }
    # @start_time = Time.now
  end

  def score
    @word = params[:word]
    @letters_array2 = JSON.parse(params[:letters])
    @letters_string = @letters_array2.join

    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)

    if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @letters_array2.count(letter) } == true
      if json['found'] == true
        @answer = "Well Done"
        # @stop_time = Time.now
      else
        @answer = "not an english word"
      end
    else
      @answer = "not in the grid"
    end
  end
end
