require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << [*('a'..'z')].sample
    end
  end

  def parse
    url = 'https://wagon-dictionary.herokuapp.com/'
    url1 = url + params[:test]
    user_serialized = open(url1).read
    user = JSON.parse(user_serialized)
    return @result = 2 if user['found'] == false
    return @result = 3 if user['found'] == true
  end

  def score
    @result = 0
    @letters = params[:letters].split(' ')
    @test = params[:test].split('')
    return @result = 1 if @test.length >= @letters.length

    @test.each do |letter|
      if @letters.include?(letter)
        @letters.delete_at(@letters.index(letter))
      else
        @result = 1
      end
    end
    parse
  end
end
