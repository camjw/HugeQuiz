require 'sinatra/base'
require_relative 'lib/game'
require_relative 'lib/player'

# This class is the wrapper for the website.
class QuizApp < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  get '/question' do
    name = params[:player_name]
    name = 'stranger' if name == ''

    session[:game] = Game.new(Player.new(name))
    erb :question
  end

  post '/answer' do
    session[:answer] = params[:answer].downcase.strip
    redirect '/answer'
  end

  get '/answer' do
    erb :result
  end
end
