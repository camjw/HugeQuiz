require_relative 'question'
require_relative 'question_getter'

# This class runs the game, generates questions and takes a player object.
class Game
  attr_reader :current_question, :asked_questions

  def initialize(player, getter: QuestionGetter.new, question_type: Question)
    @player = player
    @getter = getter
    @question_type = question_type
    @asked_questions = []
    @current_question = nil
  end

  def new_question
    next_question = @question_type.new(@getter.new_question)
    load_question(next_question) unless already_asked?(next_question)
  end

  def play_game(answer)
    score_point if correct_answer?(answer)
    correct_answer?(answer)
  end

  private

  def score_point
    @player.score_point
  end

  def correct_answer?(answer)
    @current_question.correct_answer?(answer)
  end

  def already_asked?(question)
    @asked_questions.include?(question)
  end

  def load_question(question)
    @current_question = question
    @asked_questions << question.question_id
  end
end
