# Stores details about the player i.e. name and score.
class Player
  attr_reader :name, :score, :lives

  def initialize(name)
    @name = name
    @score = 0
    @lives = 3
  end

  def score_point
    @score += 1
  end

  def lose_life
    @lives -= 1
  end

  def gain_life
    @lives += 1
  end

  def game_over?
    @lives.zero?
  end
end
