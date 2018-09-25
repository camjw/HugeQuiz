require 'pg'

def attempt_first_question
  visit '/'
  click_button 'Play!'
end

def set_database_seed(seed)
  connection = PG.connect(dbname: 'quiz_questions_test')
  connection.exec("SELECT setseed(#{seed})")
end 
