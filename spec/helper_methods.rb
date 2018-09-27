require 'pg'

def empty_test_questions_table
  conn = PG.connect(dbname: 'quiz_questions_test')
  conn.exec('TRUNCATE questions RESTART IDENTITY;')
end

def populate_test_question_table
  conn = PG.connect(dbname: 'quiz_questions_test')
  test_questions = [
    ['How many holes does a polo have?', 'One', 'Four', 'Three', 1],
    ['Which of these Broadway musicals started out as a movie?', 'Hairspray',
     'Jersey Boys', 'Evita', 0],
    ['In West Side Story, which of these is the name of one of the gangs?',
     'Hi-Hats', 'Sharks', 'Punks', 1]
  ]
  test_questions.each { |question| insert_entry_to_table(conn, question) }
end

def insert_entry_to_table(connection, question)
  connection.exec("INSERT INTO questions(question, first_answer, second_answer,
    third_answer, correct_answer) VALUES('#{question[0]}', '#{question[1]}',
    '#{question[2]}', '#{question[3]}', #{question[4]});")
end

def initialize_test_questions_table
  empty_test_questions_table
  populate_test_question_table
end

def empty_test_leaderboard
  conn = PG.connect(dbname: 'quiz_questions_test')
  conn.exec('TRUNCATE leaderboard RESTART IDENTITY;')
end

def populate_test_leaderboard
  conn = PG.connect(dbname: 'quiz_questions_test')
  test_leaders = [
    ['Billy', 10],
    ['Barry', 15],
    ['Bertie', 7]
  ]
  test_leaders.each { |leader| insert_entry_to_table(conn, leader) }
end

def insert_entry_to_leaderboard(connection, player)
  connection.exec("INSERT INTO leaderboard(name, score) VALUES('#{player[0]}',"\
  "#{player[1]});")
end

def initialize_test_leaderboard
  empty_test_leaderboard
  populate_test_leaderboard
end
