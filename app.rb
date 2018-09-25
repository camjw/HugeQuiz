require 'sinatra/base'

class QuizApp < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  get '/question' do
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
