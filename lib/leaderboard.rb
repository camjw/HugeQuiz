require 'pg'

# This class interfaces with the leaderboard database and adds new rows.
class Leaderboard
  attr_reader :database

  def initialize(database: ENV['DATABASE_URL'])
    @database = database
    @connection = PG.connect(dbname: database)
  end

  def get_leaderboard(number)
    leaders = @connection.exec('SELECT * FROM leaderboard ORDER BY score'\
      " DESC LIMIT #{number};")
    leaders.to_a
  end

  def give_random_seed(seed)
    raise 'Not a valid seed' unless valid_seed?(seed)

    @connection.exec("SELECT setseed(#{seed});")
  end

  def add_result(player)
    @connection.exec('INSERT INTO leaderboard(name, score) VALUES('\
      "'#{player.name}', #{player.score});")
  end

  def total_players
    @connection.exec('SELECT COUNT(*) FROM leaderboard;')[0]['count'].to_i
  end

  private

  def valid_seed?(seed)
    seed.is_a?(Float) && seed**2 <= 1
  end
end
