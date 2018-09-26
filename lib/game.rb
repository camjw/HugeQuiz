require_relative 'question'
require_relative 'question_getter'
require_relative 'leaderboard'

# This class runs the game, generates questions and takes a player object.
class Game
  attr_reader :current_question, :asked_questions, :player

  def initialize(player, getter: QuestionGetter.new, question_type: Question,
      leaderboard: Leaderboard.new)
    @player = player
    @getter = getter
    @question_type = question_type
    @asked_questions = []
    @current_question = nil
    @leaderboard = leaderboard
  end

  def new_question
    return 'all questions asked' if all_questions_asked?

    next_question = @question_type.new(@getter.new_question)
    return new_question if already_asked?(next_question)

    load_question(next_question)
  end

  def play_game(answer)
    score_point if correct_answer?(answer)
    correct_answer?(answer)
  end

  def total_questions
    @getter.total_questions
  end

  def all_questions_asked?
    @asked_questions.size == total_questions
  end

  def game_over?
    player.game_over?
  end

  def remaining_lives
    player.lives
  end

  def lose_life
    player.lose_life
  end

  def add_to_leaderboard
    @leaderboard.add_result(player)
  end

  def get_top_scores
    @leaderboard.get_leaderboard(20)
  end

  private

  def score_point
    @player.score_point
  end

  def correct_answer?(answer)
    @current_question.correct_answer?(answer)
  end

  def already_asked?(question)
    @asked_questions.include?(question.question_id)
  end

  def load_question(question)
    @current_question = question
    new_id = question.question_id
    @asked_questions << new_id unless @asked_questions.include?(new_id)
  end
end
