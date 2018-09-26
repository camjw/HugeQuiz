require 'pg'
require 'yaml'

# This class takes the data from the yaml file and parses it into a format
# acceptable for the SQL server, where it then deposits the information.
class TweetParser

  def initialize(database: 'quiz_questions')
    @connection = PG.connect(dbname: database)
    @data_dump = nil
  end

  def load_data(yaml_file: 'tweet_text.yml')
    @data_dump = YAML.load_file(yaml_file)
  end

  def parse_tweets
    @data_dump.each do |tweet|
      tweet_bits = tweet.split("\n")
      begin
        entry = question_and_answers(tweet_bits)
      end
      if correct_form?(entry)
        entry = remove_quotations(entry)
        store_into_database(entry)
      end
    end
  end

  def question_and_answers(bits)
    question = bits[0]
    answers = bits[1..-1].map { |answer| answer.split(')')[1] }
    answers, correct_answer = which_answer_is_correct(answers)
    [question, answers[0], answers[1], answers[2], correct_answer]
  end

  def store_into_database(entry)
    @connection.exec("INSERT INTO questions(question, first_answer, "\
      "second_answer, third_answer, correct_answer) VALUES('#{entry[0]}', "\
      "'#{entry[1]}', '#{entry[2]}', '#{entry[3]}', #{entry[4]});")
  end

  def which_answer_is_correct(answers)
    correct_answer = nil
    if answers.size == 3
      correct_answer = answers.index { |answer| answer.include?('✓') }
      answers.each {|answer| answer.slice!('✓') }
      answers.each {|answer| answer.strip! }
    end
    [answers, correct_answer]
  end

  def remove_quotations(entry)
    entry.map do |bit|
      if bit.is_a? String
        bit.gsub("'", "''")
      else
        bit
      end
    end
  end

  def correct_form?(entry)
    entry.size == 5 && entry.reduce(true) { |bool, entry| bool && (entry) }
  end
end
