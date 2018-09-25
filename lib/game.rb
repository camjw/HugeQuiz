require_relative 'question'

# This class runs the game, generates questions and takes a player object.
class Game
  def initialize(getter: QuestionGetter.new)
    @getter = getter
  end
end
