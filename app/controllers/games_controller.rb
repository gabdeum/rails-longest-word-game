require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..9).map { |_| ('A'..'Z').to_a[rand(26)] }
  end

  def score
    string_array = params[:letters].split('').join(', ')

    grid = letters_in_grid?(params[:word], params[:letters])
    english = english?(params[:word])

    if !grid
      @answer = "Sorry but #{params[:word]} can't be built out of #{string_array}"
    elsif !english
      @answer = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @answer = "Congratulation! #{params[:word]} is a valid english word!"
      session[:score] = session[:score] ? (session[:score] + params[:word].length) : params[:word].length
    end

    @score = session[:score]
  end

  private

  def letters_in_grid?(word, letters)
    if word != ''
      answer = true
      word.each_char do |char|
        answer = false unless letters.include?(char.capitalize)
      end
    else
      answer = false
    end
    answer
  end

  def english?(word)
    url = 'http://wagon-dictionary.herokuapp.com/'
    response_serialized = URI.open(url + word).read
    response = JSON.parse(response_serialized)
    response['found']
  end

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end
end
