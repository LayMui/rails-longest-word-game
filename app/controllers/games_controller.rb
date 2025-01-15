require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ("A".."Z").to_a.sample }
  end


  def score
    @user_input = params[:word]
    @grid = params[:original_letters]

    if legit_word?(@user_input)
        @message = "Not in a valid word"
    elsif in_grid?(@user_input, @grid)
        @message = "Not in the grid"
    else
        @message = "Well done"
    end
  end

  private
  def legit_word?(attempt)
    response = URI.open("https://dictionary.lewagon.com/#{attempt}").read
    response_hash = JSON.parse(response)
    response_hash["found"]
  end


  def in_grid?(attempt, grid)
    # {true, true, true}.all?
    # any? all? map each filter
    grid = grid.join.downcase
    attempt.chars.all? do |char|
      attempt.count(char) <= grid.count(char)
    end
  end
end
