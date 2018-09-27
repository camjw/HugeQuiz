require 'pg'

# This class accesses the database and retrieves questions at random.
class QuestionGetter
  attr_reader :database

  def initialize(database: 'quiz_questions')
    @database = database
    if ENV['RACK_ENV'] == 'production'
      uri = URI.parse(ENV['DATABASE_URL'])
      @connection = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
      @connection = PG.connect(dbname: database)
    end 
  end

  def new_question
    question = @connection.exec('SELECT * FROM questions ORDER BY RANDOM()'\
      ' LIMIT 1;')
    question[0]
  end

  def give_random_seed(seed)
    raise 'Not a valid seed' unless valid_seed?(seed)

    @connection.exec("SELECT setseed(#{seed});")
  end

  def total_questions
    @connection.exec('SELECT COUNT(*) FROM questions;')[0]['count'].to_i
  end

  private

  def valid_seed?(seed)
    seed.is_a?(Float) && seed**2 <= 1
  end
end
