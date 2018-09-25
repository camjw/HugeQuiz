require_relative 'question'

# This class runs the game, generates questions and takes a player object.
class Game
  attr_reader :current_question, :asked_questions

  def initialize(player, getter: QuestionGetter.new, question_type: Question)
    @getter = getter
    @question_type = question_type
    @asked_questions = []
    @current_question = nil
  end

  def new_question
    next_question = @question_type.new(@getter.new_question)
    load_question(next_question) unless already_asked?(next_question)
  end

  private

  def already_asked?(question)
    @asked_questions.include?(question)
  end

  def load_question(question)
    @current_question = question.give_question
    @asked_questions << question.question_id
  end
end
