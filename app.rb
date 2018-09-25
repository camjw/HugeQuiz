require 'sinatra/base'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/question_getter'

# This class is the wrapper for the website.
class QuizApp < Sinatra::Base
  use Rack::Session::Pool

  def initialize(getter: QuestionGetter.new)
    super
    @getter = getter
  end


  get '/' do
    erb :index
  end

  post '/initialize_game' do
    name = params[:player_name]
    name = 'stranger' if name == ''

    session[:game] = Game.new(Player.new(name), getter: @getter)
    redirect '/question'
  end

  get '/question' do
    @game = session[:game]
    redirect '/out_of_questions' if @game.all_questions_asked?

    @game.new_question
    @answers = @game.current_question.give_answers
    erb :question
  end

  post '/answer_0' do
    @game = session[:game]
    redirect '/question' if @game.play_game(0)
    redirect '/game_over'
  end

  post '/answer_1' do
    @game = session[:game]
    redirect '/question' if @game.play_game(1)
    redirect '/game_over'
  end

  post '/answer_2' do
    @game = session[:game]
    redirect '/question' if @game.play_game(2)
    redirect '/game_over'
  end

  get '/game_over' do
    @game = session[:game]
    erb :game_over
  end

  get '/out_of_questions' do
    @game = session[:game]
    erb :out_of_questions
  end
  
  public
  def set_database_seed(seed)
    @getter.give_random_seed(seed)
  end
end
