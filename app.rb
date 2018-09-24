require 'sinatra/base'

class QuizApp < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/first_question' do
    erb :question 
  end

end
