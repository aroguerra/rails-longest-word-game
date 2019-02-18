require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters_array = []
    @letters_array = Array.new(10) { ('A'..'Z').to_a.sample }
    @start_time = Time.now
  end

  def score
    @word = params[:word]
    @letters_array2 = JSON.parse(params[:letters])
    @letters_string = @letters_array2.join
    @s_time = params[:start_time]
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)

    if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @letters_array2.count(letter) } == true
      if json['found'] == true
        @answer = "Well Done"
        @final_time = Time.now - Time.parse(@s_time)
        @score = [(100 - @final_time.to_i), 1].max + @word.size
      else
        @answer = "not an english word"
        @final_time = Time.now - Time.parse(@s_time)
        @score = [(100 - @final_time.to_i), 1].max + @word.size
      end
    else
      @answer = "not in the grid"
      @final_time = Time.now - Time.parse(@s_time)
      @score = [(100 - @final_time.to_i), 1].max + @word.size

    end
  end
end
