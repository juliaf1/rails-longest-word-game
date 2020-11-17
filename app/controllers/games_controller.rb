require 'open-uri'

class GamesController < ApplicationController
  NARY_URL = "https://wagon-dictionary.herokuapp.com/"
  before_action :generate_array, :check_if_found

  def home
  end

  def new
  end

  def score
    @not_included = !check_if_included
    @not_found = !check_if_found
    # if !(check_if_included)
    #   @grid_error = "You have to use the grid letters."
    # elsif !(check_if_found)
    #   @grid_error = "You have to type a valid English word."
    # else
    #   @grid_error = "Well done!"
    # end
  end

  private

  def generate_array
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def check_if_found
    file = "#{NARY_URL}#{params['word']}"
    @word_json = JSON.parse(open(file).read)
    @word_json["found"]
  end

  def check_if_included
    @word = params["word"]
    @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
  end
end
