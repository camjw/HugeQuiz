# Stores details about the player i.e. name and score.
class Player
  attr_reader :name, :score

  def initialize(name)
    @name = name
  end
end
