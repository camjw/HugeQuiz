# Stores details about the player i.e. name and score.
class Player
  attr_reader :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def score_point
    @score += 1
  end
end
